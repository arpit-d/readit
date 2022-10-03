import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:readit/repository/authentication_repository.dart';
import 'package:readit/repository/reddit_posts_repository.dart';
import 'package:readit/repository/user_data_repository.dart';
import 'package:readit/services/credentials_storage.dart';
import 'package:readit/services/reddit_authenticator.dart';
import 'package:readit/services/reddit_posts_service.dart';
import 'package:readit/services/user_data_service.dart';

/// Global [GetIt.instance].
final GetIt locator = GetIt.instance;

/// Set up [GetIt] locator.
Future<void> setUpLocator() async {
  locator
    ..registerSingleton<FlutterSecureStorage>(FlutterSecureStorage())
    ..registerSingleton<CredentialsStorage>(CredentialsStorage())
    ..registerSingleton<RedditAuthenticator>(RedditAuthenticator())
    ..registerSingleton<AuthenticationRepository>(AuthenticationRepository())
    ..registerSingleton<UserDataService>(UserDataService())
    ..registerSingleton<RedditPostsService>(RedditPostsService())
    ..registerSingleton<RedditPostsRepository>(RedditPostsRepository())
    ..registerSingleton<UserDataRepository>(UserDataRepository());
}
