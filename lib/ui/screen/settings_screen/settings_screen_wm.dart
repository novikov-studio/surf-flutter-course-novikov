import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/context_extension.dart';
import 'package:places/ui/screen/settings_screen/settings_screen.dart';
import 'package:places/ui/screen/settings_screen/settings_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Настройки".
class SettingsScreenWM extends WidgetModel<SettingsScreen, SettingsScreenModel>
    with CommonWMMixin
    implements ISettingsScreenWidgetModel {
  @override
  bool get isDark => theme.colorScheme.brightness == Brightness.dark;

  SettingsScreenWM(SettingsScreenModel model) : super(model);

  @override
  Future<void> changeTheme({required bool isDark}) async =>
      model.changeTheme(isLight: !isDark);

  @override
  void showTutorial() {
    context.pushScreen(AppRoutes.onboarding);
  }
}

/// Интерфейс WM.
abstract class ISettingsScreenWidgetModel extends ICommonWidgetModel {
  /// Признак темной темы.
  bool get isDark;

  /// Переключение темы.
  Future<void> changeTheme({required bool isDark});

  /// Показать туториал.
  void showTutorial();
}

/// Реализация WM по-умолчанию.
SettingsScreenWM defaultSettingsScreenWidgetModelFactory(BuildContext context) {
  final appDependencies = context.read<IAppScope>();
  final model = SettingsScreenModel(
    appDependencies.errorHandler,
    appDependencies.settingsInteractor,
  );

  return SettingsScreenWM(model);
}
