import 'package:places/data/repository/shared_prefs_settings_repository.dart';

/// Интерфейс для хранения настроек приложения.
abstract class SettingsRepository {
  factory SettingsRepository.getInstance() = SharedPrefsSettingsRepository;

  /// Инициализация.
  Future<void> init();

  /// Сохранение значения по ключу.
  Future<bool> save<T>({required String key, required T value});

  /// Чтение значения по ключу.
  ///
  /// Если значение отсутствует, возвращается [defaultValue].
  T? load<T>({required String key, T? defaultValue});
}
