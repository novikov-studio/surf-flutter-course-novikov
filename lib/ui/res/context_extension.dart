import 'package:flutter/material.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:provider/provider.dart';

/// Расширение для [BuildContext].
extension ContextExtension on BuildContext {
  Future<T?> pushScreen<T extends Object?>(String name, {Object? args}) async {
    // workaround: https://github.com/flutter/flutter/issues/57186
    return await Navigator.of(this).pushNamed(name, arguments: args) as T?;
  }

  void replaceScreen(String name, {Object? args}) {
    Navigator.of(this).pushReplacementNamed(name, arguments: args);
  }

  T? routeArgs<T>() => ModalRoute.of(this)?.settings.arguments as T?;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape => !isPortrait;

  SettingsInteractor get settings => read<SettingsInteractor>();

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
