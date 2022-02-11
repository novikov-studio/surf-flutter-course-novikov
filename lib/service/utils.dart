import 'package:flutter/foundation.dart';

abstract class Utils {
  /// Выводит строку в консоль
  static void log(String text) {
    if (kDebugMode) {
      print(text);
    }
  }

  /// Выводит в консоль сообщение о нажати кнопки
  static void logButtonPressed(String buttonName) {
    log('Нажата кнопка "$buttonName"');
  }
}
