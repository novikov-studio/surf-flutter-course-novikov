import 'dart:convert';

import 'package:places/domain/repository/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранение настроек на диске с помошью [SharedPreferences].
class SharedPrefsSettingsRepository implements SettingsRepository {
  late final SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  T? load<T>({required String key, T? defaultValue}) {
    T? result;
    if (T == Map<String, dynamic>) {
      final json = _prefs.getString(key);

      result = json != null ? jsonDecode(json) as T : null;
    } else {
      result = _prefs.get(key) as T?;
    }

    return result ?? defaultValue;
  }

  @override
  Future<bool> save<T>({required String key, required T value}) {
    late Future<bool> res;

    if (value is bool) {
      res = _prefs.setBool(key, value);
    } else if (value is double) {
      res = _prefs.setDouble(key, value);
    } else if (value is int) {
      res = _prefs.setInt(key, value);
    } else if (value is String) {
      res = _prefs.setString(key, value);
    } else if (value is List<String>) {
      res = _prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      res = _prefs.setString(key, jsonEncode(value));
    } else {
      throw TypeError();
    }

    return res;
  }
}
