// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:readit/bloc/auth_bloc/auth_bloc.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';
import 'package:readit/l10n/l10n.dart';
import 'package:readit/repository/reddit_posts_repository.dart';
import 'package:readit/services/credentials_storage.dart';
import 'package:readit/services/reddit_authenticator.dart';
import 'package:readit/services/reddit_posts_service.dart';
import 'package:readit/services/user_data_service.dart';
import 'package:readit/view/screens/home_screen.dart';
import 'package:readit/view/sign_up_page.dart';

import '../core/utils/snackbars.dart';
import '../repository/authentication_repository.dart';
import '../repository/user_data_repository.dart';

class ReaditApp extends StatefulWidget {
  final RedditAuthenticator _redditAuthenticator;
  final AuthenticationRepository _authenticationRepository;
  final CredentialsStorage _credentialsStorage;
  final UserDataService _userDataService;
  final RedditPostsService _redditPostsService;
  const ReaditApp(
      {super.key,
      required AuthenticationRepository authenticationRepository,
      required RedditAuthenticator redditAuthenticator,
      required CredentialsStorage credentialsStorage,
      required UserDataService userDataService,
      required RedditPostsService redditPostsService})
      : _authenticationRepository = authenticationRepository,
        _redditAuthenticator = redditAuthenticator,
        _userDataService = userDataService,
        _credentialsStorage = credentialsStorage,
        _redditPostsService = redditPostsService;

  @override
  State<ReaditApp> createState() => _ReaditAppState();
}

class _ReaditAppState extends State<ReaditApp> {
  @override
  void initState() {
    widget._redditPostsService.fetchRedditPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: widget._authenticationRepository,
        ),
        RepositoryProvider.value(
          value: widget._redditAuthenticator,
        ),
        RepositoryProvider.value(
          value: widget._credentialsStorage,
        ),
        RepositoryProvider.value(
          value: UserDataRepository(widget._userDataService),
        ),
        RepositoryProvider.value(
          value: RedditPostsRepository(widget._redditPostsService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFFe80040)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF5956ed),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<AuthBloc>(
          lazy: false,
          create: (BuildContext context) =>
              AuthBloc(widget._authenticationRepository)
                ..add(CheckAuthStatusEvent()),
          child: AuthWrapper(),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated)
          showSnackbar(
            context,
            message: 'Logged In Successfully!',
            snackbarType: SnackbarType.error,
          );
        if (state is Unauthenticated)
          showSnackbar(
            context,
            message: 'Logged Out!',
            snackbarType: SnackbarType.error,
          );
      },
      builder: (context, state) {
        if (state is Authenticated) {
          // return BlocProvider(
          //   create: (context) =>
          //       UserDataCubit(context.read<UserDataRepository>()),
          //   child: ProfilePage(),
          // );
          return BlocProvider(
            create: (context) =>
                RedditPostsBloc(context.read<RedditPostsRepository>())
                  ..add(LoadRedditPosts()),
            child: HomeScreen(),
          );
        }
        if (state is CheckAuthStatusEvent) return CircularProgressIndicator();
        if (state is Unauthenticated || state is AuthInitial)
          return SignUpPage();
        if (state is AuthenticationFailure) return Text(state.errorMessage);
        return SignUpPage();
      },
    );
  }
}


// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: context.read<AuthenticationRepository>().isSignedIn(),
//       builder: (context, snapshot) {
//         print(snapshot.hasData);
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             if (snapshot.data != null && snapshot.data == true) {
//               return ProfilePage();
//             } else {
//               return SignUpPage();
//             }
//           }
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
