import 'package:flutter/material.dart';

enum SnackbarType {
  success,
  error,
  warning,
}

ScaffoldMessengerState showSnackbar(
  BuildContext context, {
  required String message,
  required SnackbarType snackbarType,
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            //  fontFamily: AppTheme.fontFamily,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
}
