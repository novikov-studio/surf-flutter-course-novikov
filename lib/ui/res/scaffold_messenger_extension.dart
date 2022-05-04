import 'package:flutter/material.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/res/theme_extension.dart';

extension ScaffoldMessengerExtension on ScaffoldMessengerState {
  void showError(String message, {bool critical = true}) {
    final theme = Theme.of(context);

    final bgColor =
        critical ? theme.colorScheme.error : theme.colorScheme.yellow;

    final fgColor =
        critical ? theme.colorScheme.onError : theme.colorScheme.main;

    showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyText1?.copyWith(color: fgColor),
        ),
        backgroundColor: bgColor,
      ),
    );
  }

  void showWarning(String message) => showError(message, critical: false);

  void showExpError(Exception e) =>
      showError(e.humanReadableText, critical: e.isCritical);

  void showObjError(Object e) =>
      showError(Errors.humanReadableText(e), critical: Errors.isCritical(e));
}
