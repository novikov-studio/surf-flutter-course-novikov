import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/context_extension.dart';
import 'package:places/ui/res/scaffold_messenger_extension.dart';

/// Примесь для WM для запроса разрешений на использование геолокации.
mixin GeoPermissionsWMMixin<W extends ElementaryWidget,
        M extends ElementaryModel> on WidgetModel<W, M>
    implements IGeoPermissionsWidgetModel {
  static bool _askService = true;
  static bool _askDenied = true;
  static bool _askDeniedForever = true;

  @override
  Future<void> checkGeoPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _checkAndroidGeoPermissions();
    }
  }

  /// Проверка разрешений на Android.
  Future<void> _checkAndroidGeoPermissions() async {
    /// Проверяем, включен ли сервис.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (_askService && isMounted) {
        _askService = false;
        // ignore: use_build_context_synchronously
        final needShowSettings = await context.showYesNoDialog(
          title: AppStrings.geoServiceOff,
          text: AppStrings.showGeoSettings,
        );
        if (needShowSettings) {
          await Geolocator.openLocationSettings();
        }
      }
    }

    /// Проверяем разрешения приложения
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      if (_askDenied) {
        permission = await Geolocator.requestPermission();
        // Ложное срабатывание линтера
        // ignore: invariant_booleans
        if (permission == LocationPermission.denied) {
          if (_askDenied && isMounted) {
            _askDenied = false;
            // ignore: use_build_context_synchronously
            final needShowSettings = await context.showYesNoDialog(
              title: AppStrings.geoDenied,
              text: AppStrings.showAppSettings,
            );
            if (needShowSettings) {
              await Geolocator.openAppSettings();
            }
          }
        }
      }
    }

    /// Уведомление о постоянном запрете.
    if (permission == LocationPermission.deniedForever) {
      if (_askDeniedForever && isMounted) {
        _askDeniedForever = false;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showWarning(AppStrings.geoDeniedForever);
      }
    }
  }
}

/// Интерфейс WMю
mixin IGeoPermissionsWidgetModel {
  /// Проверка разрешений.
  Future<void> checkGeoPermissions();
}
