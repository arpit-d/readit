import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:readit/core/locator.dart';
import '../repository/authentication_repository.dart';

class RedditPostsService {
  final AuthenticationRepository _authenticationRepository;

  RedditPostsService({AuthenticationRepository? authenticationRepository})
      : _authenticationRepository =
            authenticationRepository ?? locator.get<AuthenticationRepository>();
  final url = "https://oauth.reddit.com/.json?limit=25";

  Future<String> fetchRedditPosts() async {
    final accessToken =
        await _authenticationRepository.getSignedInCredentials();
    log(accessToken!);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'bearer $accessToken',
        'User-Agent': 'ReadIt by /u/arpdp',
        'Content-Type': 'application/json',
      },
    );
    return response.body;
  }
}
