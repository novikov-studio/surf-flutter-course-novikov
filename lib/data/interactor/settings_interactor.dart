import 'package:flutter/foundation.dart';
import 'package:places/data/repository_interface/settings_repository.dart';

/// Интерактор для управления настройками приложения.
class SettingsInteractor extends ChangeNotifier {
  static const _lightTheme = 'lightTheme';

  final SettingsRepository _settingsRepository;

  bool get isLightTheme =>
      _settingsRepository.load<bool>(key: _lightTheme) ?? true;

  bool get showTutorialOnStart => true;

  SettingsInteractor({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  Future<void> saveTheme({required bool isLight}) async {
    await _settingsRepository.save<bool>(key: _lightTheme, value: isLight);
    notifyListeners();
  }
}
