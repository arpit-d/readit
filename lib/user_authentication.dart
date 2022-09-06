import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:readit/secrets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_to_front/window_to_front.dart';

class UserAuthentication {
  late final HttpServer server;
  late final String _accessToken;

  static const _redditApiUrl = 'https://www.reddit.com/api/v1';
  static const _uriRedirect = 'http://localhost:8080';
  static const _scopeIdentities =
      '''identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread''';

  String get accessToken => _accessToken;

  Future<void> authenticateUser() async {
    final randomStateString = generateRandomString(16);
    final url =
        '$_redditApiUrl/authorize?client_id=$CLIENT_ID&response_type=code&state=$randomStateString&redirect_uri=$_uriRedirect/&duration=permanent&scope=$_scopeIdentities';
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );
      final accessCode = await retrieveCodeFromServer(randomStateString);
      final accessToken = await retrieveAccessToken(accessCode);
      final userData = await getUserData(accessToken);
      print(userData);
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
        print(state);
        if (state == randomStateString) {
          final code = request.uri.queryParameters['code'];

          if (Platform.isWindows) await WindowToFront.activate();
          request.response
            ..statusCode = 200
            ..headers.set('Content-Type', ContentType.html.mimeType)
            ..write(
              '<html><meta name="viewport" content="width=device-width, initial-scale=1.0"><body> <h2 style="text-align: center; position: absolute; top: 50%; left: 50%: right: 50%">Welcome to ReadIt</h2><h3>You can close this window<script type="javascript">window.close()</script> </h3></body></html>',
            );
          await request.response.close();
          await server.close(force: true);
          onCode.add(code!);
          await onCode.close();
        } else {
          await request.response.close();
          await server.close(force: true);
          await onCode.close();
          throw Exception(
              'The state string generated doesn\'t match the string retrieved from local host');
        }
      },
    );
    return onCode.stream.first;
  }

  Future<String> getUserData(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://oauth.reddit.com/api/v1/me'),
      headers: {
        'Authorization': 'bearer $accessToken',
        'User-Agent': 'ReadIt by /u/arpdp'
      },
    );
    return response.body;
  }

  Future<String> retrieveAccessToken(String accessCode) async {
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
      final map = json.decode(response.body) as Map<String, dynamic>;
      print(map['access_token']);
      _accessToken = map['access_token'] as String;
      return _accessToken;
    } else {
      throw Exception('Couldn\'t retrieve Access Tokenb');
    }
  }

  String generateRandomString(int len) {
    var r = Random();

    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
