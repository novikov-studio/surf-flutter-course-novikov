import 'package:flutter/foundation.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/repository/settings_repository.dart';
import 'package:places/ui/res/logger.dart';

/// Интерактор для управления настройками приложения.
class SettingsInteractor extends ChangeNotifier {
  static const _lightTheme = 'lightTheme';
  static const _filter = 'filter';

  final SettingsRepository _settingsRepository;

  bool get isLightTheme =>
      _settingsRepository.load<bool>(key: _lightTheme) ?? true;

  bool get showTutorialOnStart => true;

  /// Чтение фильтра поиска.
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

  Future<void> saveTheme({required bool isLight}) async {
    await _settingsRepository.save<bool>(key: _lightTheme, value: isLight);
    notifyListeners();
  }

  /// Сохранение фильтра поиска.
  Future<bool> saveFilter(Filter filter) async =>
      _settingsRepository.save(key: _filter, value: filter.toJson());
}
