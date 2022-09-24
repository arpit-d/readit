import 'package:readit/services/reddit_authenticator.dart';

class AuthenticationRepository {
  final RedditAuthenticator _redditAuthenticator;

  AuthenticationRepository(RedditAuthenticator? redditAuthenticator)
      : _redditAuthenticator = redditAuthenticator ?? RedditAuthenticator();

  String? retrieveAccessToken() => _redditAuthenticator.accessToken;

  Future<void> signIn() async {
    try {
      await _redditAuthenticator.authenticateUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() => _redditAuthenticator.signOut();

  Future<bool> isSignedIn() async => await _redditAuthenticator.isSignedIn();

  Future<String?> getSignedInCredentials() =>
      _redditAuthenticator.getSignInCredentials();
}
