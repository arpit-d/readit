import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(AuthSignInEvent()),
              child: const Text('Log In'),
            ),
          ],
        ));
  }
}
