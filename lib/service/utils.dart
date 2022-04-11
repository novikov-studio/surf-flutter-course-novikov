import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places/service/location.dart';

// todo: Удалить
abstract class Utils {
  static ValueNotifier<bool> isLight = ValueNotifier(true);

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

  static double calcDistance(Location point1, Location point2) {
    const factorY = 40000 / 360;
    final factorX = cos(pi * point1.latitude / 180.0) * factorY;
    final deltaX = (point1.longitude - point2.longitude).abs() * factorX;
    final deltaY = (point1.latitude - point2.latitude).abs() * factorY;

    return sqrt(deltaX * deltaX + deltaY * deltaY);
  }

  /// Определяет, находится ли точка [point] в радиусе
  ///  не менее, чем [minRadius] км и не более, чем [maxRadius] км
  ///  от исходной точки [center]
  static bool isPointInRingArea({
    required Location point,
    required Location center,
    required double? minRadius,
    required double maxRadius,
  }) {
    final distance = calcDistance(center, point);

    return (minRadius == null || distance >= minRadius) &&
        distance <= maxRadius;
  }

  /// Формирует URL для отображения списка точек на Яндекс.Картах
  // https://yandex.com/dev/yandex-apps-launch/maps/doc/concepts/yandexmaps-web.html#yandexmaps-web__section_b3b_cst_ngb
  static String buildYandexMapsUrl({
    required Location current,
    required Iterable<Location> points,
  }) {
    final curr = '${current.longitude},${current.latitude}';
    final lst = points
        .map((p) => '${p.longitude},${p.latitude}')
        .toList(growable: false)
        .join('~');

    final url = 'https://yandex.ru/maps/?ll=$curr&pt=$lst&z=13';
    log(url);

    return url;
  }
}
