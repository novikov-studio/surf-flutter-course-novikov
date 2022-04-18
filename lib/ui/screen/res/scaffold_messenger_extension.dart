import 'package:flutter/material.dart';

extension ScaffoldMessengerExtension on ScaffoldMessengerState {
  void showError(String message) {
    final theme = Theme.of(context);

    showSnackBar(SnackBar(
      content: Text(
        message,
        style: theme.textTheme.bodyText1?.copyWith(
          color: theme.colorScheme.onError,
        ),
      ),
      backgroundColor: theme.colorScheme.error,
    ));
  }
}
