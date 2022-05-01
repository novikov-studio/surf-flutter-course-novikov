import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/settings_screen/settings_screen_wm.dart';
import 'package:places/ui/widget/simple_app_bar.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Экран "Настройки".
class SettingsScreen extends ElementaryWidget<ISettingsScreenWidgetModel> {
  const SettingsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISettingsScreenWidgetModel wm) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: AppStrings.settingsTitle,
      ),
      body: DefaultTextStyle(
        style: wm.theme.textTheme.text400,
        child: Column(
          children: [
            ListTile(
              title: const Text(AppStrings.darkTheme),
              trailing: CupertinoSwitch(
                value: wm.isDark,
                onChanged: (value) => wm.changeTheme(isDark: value),
              ),
            ),
            ListTile(
              title: const Text(AppStrings.watchTutorial),
              trailing: IconButton(
                color: wm.theme.colorScheme.green,
                splashRadius: 24.0,
                icon: const SvgIcon(AppIcons.info),
                onPressed: wm.showTutorial,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
