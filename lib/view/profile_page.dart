// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../cubit/user_data_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF1f1d28),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.read<AuthBloc>().add(AuthSignOutEvent()),
            child: Text('Sign Out'),
          ),
        ],
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoadingState) {
            return CircularProgressIndicator();
          }
          if (state is UserDataErrorState) {
            return Text('Something went wrong!');
          }
          if (state is UserDataLoadedState) {
            final data = state.userData;
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        '${data.iconImg}',
                      ),
                    ),
                  ),
                  Text(
                    '${data.name}',
                    //  style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${data.totalKarma}',
//style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ReadIt Profile'),
//       ),
//       body: const CounterText(),
//     );
//   }
// }

// class CounterText extends StatefulWidget {
//   const CounterText({super.key});

//   @override
//   State<CounterText> createState() => _CounterTextState();
// }

// class _CounterTextState extends State<CounterText> {
//   // late final UserDataService userDataService;
//   @override
//   void initState() {
//     //   userDataService = UserDataService(context.read<RedditAuthenticator>());

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<UserDataCubit, UserDataState>(
//         builder: (context, state) {
//           if (state is UserDataLoadingState) {
//             return CircularProgressIndicator();
//           }
//           if (state is UserDataErrorState) {
//             return Text('err');
//           }
//           if (state is UserDataLoadedState) {
//             final data = state.userData;
//             return Column(
//               children: [
//                 Text('Signed In'),
//                 ElevatedButton(
//                   onPressed: () =>
//                       context.read<AuthBloc>().add(AuthSignOutEvent()),
//                   child: Text('Sign Out'),
//                 ),
//                 Text('${data.name}'),
//               ],
//             );
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
