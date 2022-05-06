import 'package:flutter/foundation.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/repository/settings_repository.dart';
import 'package:places/ui/res/logger.dart';

/// Интерактор для управления настройками приложения.
class SettingsInteractor extends ChangeNotifier {
  static const _lightTheme = 'lightTheme';
  static const _filter = 'filter';
  static const _showTutorialOnStart = 'showTutorialOnStart';

  final SettingsRepository _settingsRepository;

  /// Чтение флага "Светлая тема".
  bool get isLightTheme =>
      _settingsRepository.load<bool>(key: _lightTheme) ?? true;

  /// Чтение флага "Показывать экран онбординга при запуске".
  bool get showTutorialOnStart =>
      _settingsRepository.load<bool>(key: _showTutorialOnStart) ?? true;

  /// Чтение параметра "Фильтр поиска".
  Filter get filter {
    try {
      final json = _settingsRepository.load<Map<String, dynamic>>(
        key: _filter,
      );

      return json != null ? Filter.fromJson(json) : const Filter();
    } on Object catch (e, stacktrace) {
      logError(e, stacktrace);

      return const Filter();
    }
  }

  SettingsInteractor({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  /// Сохранение флага "Светлая тема".
  Future<void> saveTheme({required bool isLight}) async {
    await _settingsRepository.save(key: _lightTheme, value: isLight);
    notifyListeners();
  }

  /// Сохранение флага "Показывать экран онбординга при запуске".
  Future<void> saveShowTutorialOnStart({required bool value}) async {
    await _settingsRepository.save(
      key: _showTutorialOnStart,
      value: value,
    );
  }

  /// Сохранение пармаетра "Фильтр поиска".
  Future<bool> saveFilter(Filter filter) async =>
      _settingsRepository.save(key: _filter, value: filter.toJson());
}
