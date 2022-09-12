import 'package:readit/services/reddit_authenticator.dart';

class AuthenticationRepository {
  final RedditAuthenticator _redditAuthenticator;

  AuthenticationRepository(RedditAuthenticator? redditAuthenticator)
      : _redditAuthenticator = redditAuthenticator ?? RedditAuthenticator();

  Future<void> signIn() async {
    try {
      _redditAuthenticator.authenticateUser();
    } catch (e) {}
  }

  Future<void> signOut() => _redditAuthenticator.signOut();

  Future<bool> isSignedIn() => _redditAuthenticator.isSignedIn();
}
