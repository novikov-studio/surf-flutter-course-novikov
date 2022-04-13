import 'package:places/data/repository_interface/settings_repository.dart';

/// Хранение настроек в памяти.
class MemorySettingsRepository implements SettingsRepository {
  final _data = <String, dynamic>{};

  @override
  T? load<T>({required String key}) {
    return _data[key] as T?;
  }

  @override
  Future<void> save<T>({required String key, required T value}) async {
    _data[key] = value;
  }
}
