import 'package:flutter/material.dart';
import 'package:places/ui/const/app_strings.dart';

/// Расширение для [BuildContext].
extension ContextExtension on BuildContext {
  Future<bool> showYesNoDialog({
    String? title,
    required String text,
    String yesButtonText = AppStrings.yes,
    String noButtonText = AppStrings.no,
  }) async {
    final result = await showDialog<bool?>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: SingleChildScrollView(
            child: Text(text),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(yesButtonText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(noButtonText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
