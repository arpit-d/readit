import 'dart:developer';

import 'package:http/http.dart' as http;

import '../repository/authentication_repository.dart';

class UserDataService {
  final AuthenticationRepository _authenticationRepository;
  UserDataService(this._authenticationRepository) {}
  Future<String> getUserData() async {
    final accessToken =
        await _authenticationRepository.getSignedInCredentials();
    log(accessToken!);
    final response = await http.get(
      Uri.parse('https://oauth.reddit.com/api/v1/me.json'),
      headers: {
        'Authorization': 'bearer $accessToken',
        'User-Agent': 'ReadIt by /u/arpdp',
        'Content-Type': 'application/json',
      },
    );
    return response.body;
  }
}
