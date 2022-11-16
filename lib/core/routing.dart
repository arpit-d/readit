import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readit/repository/user_data_repository.dart';
import 'package:readit/view/profile_page.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../cubit/user_data_cubit.dart';
import '../repository/authentication_repository.dart';
import '../view/app.dart';
import 'locator.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => BlocProvider<AuthBloc>(
              lazy: false,
              create: (BuildContext context) =>
                  AuthBloc(locator.get<AuthenticationRepository>())
                    ..add(CheckAuthStatusEvent()),
              child: AuthWrapper(),
            ),
        routes: [
          GoRoute(
            path: "profile",
            builder: (context, state) => BlocProvider(
              create: (context) =>
                  UserDataCubit(locator.get<UserDataRepository>()),
              child: ProfilePage(),
            ),
          )
        ]),
  ],
);
