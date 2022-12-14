// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:readit/bloc/auth_bloc/auth_bloc.dart';
import 'package:readit/bloc/reddit_posts_bloc/reddit_posts_bloc.dart';
import 'package:readit/core/locator.dart';
import 'package:readit/core/theme/custom_theme.dart';
import 'package:readit/cubit/user_data_cubit.dart';
import 'package:readit/l10n/l10n.dart';
import 'package:readit/repository/reddit_posts_repository.dart';
import 'package:readit/view/screens/sign_up_page.dart';

import '../core/utils/snackbars.dart';
import '../core/routing.dart';
import '../repository/user_data_repository.dart';
import 'screens/home_screen.dart';

class ReaditApp extends StatefulWidget {
  const ReaditApp({super.key});

  @override
  State<ReaditApp> createState() => _ReaditAppState();
}

class _ReaditAppState extends State<ReaditApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // or any color you want
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: CustomTheme.lightTheme,
      supportedLocales: AppLocalizations.supportedLocales,
      // home: BlocProvider<AuthBloc>(
      //   lazy: false,
      //   create: (BuildContext context) =>
      //       AuthBloc(locator.get<AuthenticationRepository>())
      //         ..add(CheckAuthStatusEvent()),
      //   child: AuthWrapper(),
      // ),
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    RedditPostsBloc(locator.get<RedditPostsRepository>())
                      ..add(LoadRedditPosts()),
              ),
              BlocProvider(
                create: (context) => UserDataCubit(
                  locator.get<UserDataRepository>(),
                ),
              ),
            ],
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
