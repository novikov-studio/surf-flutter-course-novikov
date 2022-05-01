import 'package:elementary/elementary.dart';
import 'package:places/domain/interactor/settings_interactor.dart';

/// Модель экрана "Настройки".
class SettingsScreenModel extends ElementaryModel {
  final SettingsInteractor _settingsInteractor;

  SettingsScreenModel(
    ErrorHandler errorHandler,
    SettingsInteractor settingsInteractor,
  )   : _settingsInteractor = settingsInteractor,
        super(errorHandler: errorHandler);

  Future<void> changeTheme({required bool isLight}) async {
    await _settingsInteractor.saveTheme(isLight: isLight);
  }
}
