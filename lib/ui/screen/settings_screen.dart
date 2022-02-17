import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.colorScheme.isLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settingsTitle),
      ),
      body: DefaultTextStyle(
        style: theme.textTheme.text,
        child: Column(
          children: [
            ListTile(
              title: const Text(AppStrings.darkTheme),
              trailing: CupertinoSwitch(
                value: !isLight,
                onChanged: (value) {
                  Utils.isLight.value = !value;
                },
              ),
            ),
            ListTile(
              title: const Text(AppStrings.watchTutorial),
              trailing: IconButton(
                color: theme.colorScheme.green,
                splashRadius: 24.0,
                icon: const SvgIcon(AppIcons.info),
                onPressed: () {
                  Utils.logButtonPressed('settings.tutorial');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
