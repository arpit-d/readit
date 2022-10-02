// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:readit/services/reddit_posts_service.dart';
import 'package:readit/view/app.dart';
import 'package:readit/bootstrap.dart';

import 'repository/authentication_repository.dart';
import 'services/credentials_storage.dart';
import 'services/reddit_authenticator.dart';
import 'services/user_data_service.dart';

void main() {
  final credentialsStorage = CredentialsStorage();
  final redditAuthenticator =
      RedditAuthenticator(credentialsStorage: credentialsStorage);
  final authenticationRepository =
      AuthenticationRepository(redditAuthenticator);
  final UserDataService userDataService =
      UserDataService(authenticationRepository);
  final RedditPostsService redditPostsService =
      RedditPostsService(authenticationRepository);
  bootstrap(() => ReaditApp(
        authenticationRepository: authenticationRepository,
        redditAuthenticator: redditAuthenticator,
        credentialsStorage: credentialsStorage,
        userDataService: userDataService,
        redditPostsService: redditPostsService,
      ));
}
