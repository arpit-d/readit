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
import 'package:readit/counter/counter.dart';
import 'package:readit/l10n/l10n.dart';
import 'package:readit/services/credentials_storage.dart';
import 'package:readit/services/reddit_authenticator.dart';
import 'package:readit/view/sign_up_page.dart';

import '../repository/authentication_repository.dart';

class ReaditApp extends StatelessWidget {
  final RedditAuthenticator _redditAuthenticator;
  final AuthenticationRepository _authenticationRepository;
  final CredentialsStorage _credentialsStorage;
  const ReaditApp({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required RedditAuthenticator redditAuthenticator,
    required CredentialsStorage credentialsStorage,
  })  : _authenticationRepository = authenticationRepository,
        _redditAuthenticator = redditAuthenticator,
        _credentialsStorage = credentialsStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _redditAuthenticator,
        ),
        RepositoryProvider.value(
          value: _credentialsStorage,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF507DD7)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF507DD7),
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
              AuthBloc(_authenticationRepository)..add(CheckAuthStatusEvent()),
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
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is Authenticated) return ProfilePage();
        if (state is Unauthenticated) return SignUpPage();
        if (state is AuthenticationFailure) return Text(state.errorMessage);
        return CircularProgressIndicator();
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
