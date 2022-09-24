import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:readit/models/access_token_response_model.dart';
import 'package:readit/secrets.dart';
import 'package:readit/services/credentials_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_to_front/window_to_front.dart';

class RedditAuthenticator {
  final CredentialsStorage _credentialsStorage;
  RedditAuthenticator({CredentialsStorage? credentialsStorage})
      : _credentialsStorage = credentialsStorage ?? CredentialsStorage();

  // Check already initialized error
  late HttpServer server;
  String? _accessToken;

  static const _redditApiUrl = 'https://www.reddit.com/api/v1';
  static const _uriRedirect = 'http://localhost:8080';
  static const _scopeIdentities =
      '''identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread''';

  String? get accessToken => _accessToken;

  Future<void> authenticateUser() async {
    final randomStateString = generateRandomString(16);
    final url =
        '$_redditApiUrl/authorize?client_id=$CLIENT_ID&response_type=code&state=$randomStateString&redirect_uri=$_uriRedirect/&duration=permanent&scope=$_scopeIdentities';
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );
      try {
        dev.log('Launching authentication URL in browser');
        final accessCode = await retrieveCodeFromServer(randomStateString);
        final accessToken = await retrieveAccessToken(accessCode);
        print(accessToken.expiresIn.millisecondsSinceEpoch);
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<String> retrieveCodeFromServer(String randomStateString) async {
    final onCode = StreamController<String>();
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    server.listen(
      (HttpRequest request) async {
        final state = request.uri.queryParameters['state'];
        final error = request.uri.queryParameters['error'];
        try {
          if (state == randomStateString) {
            if (error == null) {
              final code = request.uri.queryParameters['code'];
              writeHtmlInAString(
                  request, 'Welcome to ReadIt', 'You can close this window');
              onCode.add(code!);
            } else {
              throw Exception('Authentication Failed!');
            }
          } else {
            throw Exception(
                'The state string generated doesn\'t match the string retrieved from local host');
          }
        } catch (e, _) {
          writeHtmlInAString(request, 'Authentication Failed due to $error',
              'You can close this window & retry again from the app');
          throw Exception(e.toString());
        } finally {
          if (Platform.isWindows) await WindowToFront.activate();
          await request.response.close();
          await server.close(force: true);
          await onCode.close();
        }
      },
    );
    return onCode.stream.first;
  }

  Future<AccessTokenResponseModel> retrieveAccessToken(
      String accessCode) async {
    const user = CLIENT_ID;
    const password = '';

    final basicAuth = 'Basic ${base64Encode(utf8.encode('$user:$password'))}';
    final response = await http.post(
      Uri.parse('https://www.reddit.com/api/v1/access_token'),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body:
          'grant_type=authorization_code&code=$accessCode&redirect_uri=http://localhost:8080/',
    );
    if (response.statusCode == 200) {
      dev.log('RESPONSE STATUS CODE: ${response.statusCode}');
      final responseData =
          AccessTokenResponseModel.fromJson(response.body.toString());
      await _credentialsStorage.save(responseData);
      return responseData;
    } else {
      throw Exception('Couldn\'t retrieve Access Token');
    }
  }

  Future<String?> getSignInCredentials() async {
    try {
      if (_accessToken != null) {
        dev.log('Returning accessToken from cache');
        return _accessToken;
      }
      final storedCredentials = await _credentialsStorage.read();
      if (storedCredentials != null) {
        dev.log('Returning accessToken from storage');
        return _accessToken = storedCredentials.accessToken;
      }
      dev.log('No accessToken found, returning null');
      return null;
    } on PlatformException {
      print('platformException');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      dev.log('Signing out user');
      _accessToken = null;
      _credentialsStorage.delete();
    } catch (e) {}
  }

  Future<bool> isSignedIn() async =>
      await getSignInCredentials().then((credentials) => credentials != null);

  String generateRandomString(int len) {
    var r = Random();

    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  Object writeHtmlInAString(HttpRequest request, String text1, String text2) {
    return request.response
      ..statusCode = 200
      ..headers.set('Content-Type', ContentType.html.mimeType)
      ..write(
        '<html><meta name="viewport" content="width=device-width, initial-scale=1.0"><body> <h2 style="text-align: center; position: absolute; top: 50%; left: 50%: right: 50%">$text1</h2><h3>$text2<script type="javascript">window.close()</script> </h3></body></html>',
      );
  }
}
