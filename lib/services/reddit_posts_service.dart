import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:readit/core/locator.dart';
import '../repository/authentication_repository.dart';

class RedditPostsService {
  final AuthenticationRepository _authenticationRepository;

  RedditPostsService({AuthenticationRepository? authenticationRepository})
      : _authenticationRepository =
            authenticationRepository ?? locator.get<AuthenticationRepository>();
  final url = "https://oauth.reddit.com/.json?";

  Future<String> fetchRedditPosts(int postLimit) async {
    try {
      final accessToken =
          await _authenticationRepository.getSignedInCredentials();
      log(accessToken!);
      final response = await http.get(
        Uri.parse(url + "limit=$postLimit"),
        headers: {
          'Authorization': 'bearer $accessToken',
          'User-Agent': 'ReadIt by /u/arpdp',
          'Content-Type': 'application/json',
        },
      );
      return response.body;
    } on SocketException {
      throw Exception('No Network Found!');
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<String> getListOfSubscribedSubreddits() async {
    try {
      final accessToken =
          await _authenticationRepository.getSignedInCredentials();
      log(accessToken!);
      final response = await http.get(
        Uri.parse(
            'https://oauth.reddit.com/subreddits/mine/subscriber.json?limit=100'),
        headers: {
          'Authorization': 'bearer $accessToken',
          'User-Agent': 'ReadIt by /u/arpdp',
          'Content-Type': 'application/json',
        },
      );
      return response.body;
    } on SocketException {
      throw Exception('No Network Found!');
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
