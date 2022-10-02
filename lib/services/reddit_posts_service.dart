import 'dart:developer';

import 'package:http/http.dart' as http;
import '../repository/authentication_repository.dart';

class RedditPostsService {
  final AuthenticationRepository _authenticationRepository;
  final url = "https://oauth.reddit.com/.json?limit=25";
  RedditPostsService(this._authenticationRepository);
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
