import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:provider/provider.dart';

/// Экран "Настройки".
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.colorScheme.isLight;

    return Scaffold(
      appBar: SimpleAppBar(
        title: AppStrings.settingsTitle,
      ),
      body: DefaultTextStyle(
        style: theme.textTheme.text400,
        child: Column(
          children: [
            ListTile(
              title: const Text(AppStrings.darkTheme),
              trailing: CupertinoSwitch(
                value: !isLight,
                onChanged: (value) => _changeTheme(context, isLight: !value),
              ),
            ),
            ListTile(
              title: const Text(AppStrings.watchTutorial),
              trailing: IconButton(
                color: theme.colorScheme.green,
                splashRadius: 24.0,
                icon: const SvgIcon(AppIcons.info),
                onPressed: () => _showTutorial(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeTheme(
    BuildContext context, {
    required bool isLight,
  }) async {
    await context.read<SettingsInteractor>().saveTheme(isLight: isLight);
  }

  void _showTutorial(BuildContext context) {
    context.pushScreen(AppRoutes.onboarding);
  }
}
