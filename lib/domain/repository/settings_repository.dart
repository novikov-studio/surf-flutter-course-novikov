import 'package:places/data/repository/memory_settings_repository.dart';

/// Интерфейс для хранения настроек приложения.
abstract class SettingsRepository {
  factory SettingsRepository.getInstance() = MemorySettingsRepository;

  /// Сохранение значения по ключу.
  Future<void> save<T>({required String key, required T value});

  /// Чтение значения по ключу.
  T? load<T>({required String key});
}
