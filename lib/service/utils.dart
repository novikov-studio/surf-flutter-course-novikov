import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places/service/location.dart';

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

  /// Определяет, находится ли точка [point] в радиусе не более, чем [radius] км от исходной точки [center]
  static bool isPointInCircleArea({
    required Location point,
    required Location center,
    required double radius,
  }) {
    const factorY = 40000 / 360;
    final factorX = cos(pi * center.latitude / 180.0) * factorY;
    final deltaX = (center.longitude - point.longitude).abs() * factorX;
    final deltaY = (center.latitude - point.latitude).abs() * factorY;

    return sqrt(deltaX * deltaX + deltaY * deltaY) <= radius;
  }

  /// Определяет, находится ли точка [point] в радиусе
  ///  не менее, чем [minRadius] км и не более, чем [maxRadius] км
  ///  от исходной точки [center]
  static bool isPointInRingArea({
    required Location point,
    required Location center,
    required double minRadius,
    required double maxRadius,
  }) {
    return isPointInCircleArea(
          point: point,
          center: center,
          radius: maxRadius,
        ) &&
        !isPointInCircleArea(
          point: point,
          center: center,
          radius: minRadius,
        );
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
