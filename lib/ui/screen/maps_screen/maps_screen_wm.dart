import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/logger.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/maps_screen/maps_screen.dart';
import 'package:places/ui/screen/maps_screen/maps_screen_model.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/geo_permissions_wm_mixin.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/sight_list_wm_mixin.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/state_notifier_builder_ex.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Карта".
class MapsScreenWM extends WidgetModel<MapsScreen, MapsScreenModel>
    with
        CommonWMMixin,
        SightListWMMixin,
        GeoPermissionsWMMixin,
        TickerProviderWidgetModelMixin
    implements IMapsScreenWidgetModel {
  static const _lightModeUrl =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png';
  static const _darkModeUrl =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';

  final _mapController = MapController();
  final _searchLocationState = EntityStateNotifier<Location>();
  final _selectedSight = StateNotifier<Sight>();
  final _mapRebuilder = StreamController<void>.broadcast();

  @override
  Location? get lastLocation => model.lastLocation;

  @override
  String get mapUrl => theme.colorScheme.isLight ? _lightModeUrl : _darkModeUrl;

  @override
  MapController get mapController => _mapController;

  @override
  NullStream get mapRebuild => _mapRebuilder.stream;

  @override
  ListenableEntityState<Location> get searchLocationState =>
      _searchLocationState;

  @override
  bool get autoLoadSight => false;

  @override
  ListenableState<Sight> get selectedSight => _selectedSight;

  MapsScreenWM(MapsScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _mapController.onReady.then((_) => showCurrentLocation());
    sightsState.addListener(_rebuildMap);
  }

  @override
  void dispose() {
    _mapRebuilder.close();
    sightsState.removeListener(_rebuildMap);
    super.dispose();
  }

  @override
  Future<void> showCurrentLocation() async {
    await checkGeoPermissions();

    _searchLocationState.loading();
    try {
      final location = await model.getCurrentLocation();
      if (location != null) {
        _searchLocationState.content(location);
        _animatedMove(
          location.asLatLng,
          _mapController.zoom > 13 ? _mapController.zoom : 14,
        );
      } else {
        await loadSights();
        _searchLocationState.initial();
      }
    } on Object catch (e) {
      logError(e);
      _searchLocationState.initial();
    }
  }

  @override
  void selectSight(Sight? sight) {
    if (!_selectedSight.equalsById(sight)) {
      _selectedSight.accept(sight);
      _rebuildMap();
    }
  }

  /// Анимированное перемещение по карте в заданную точку.
  void _animatedMove(LatLng destLocation, double destZoom) {
    // Формируем начальные и конечные точки анимации
    final latTween = Tween<double>(
      begin: _mapController.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: _mapController.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Создаем контроллер анимации
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Задаем кривую анимации
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );

    // Подписываемся на проигрывание анимации
    animationController.addListener(() {
      // Перемещаемся по карте в очередную интерполированную точку
      if (isMounted) {
        _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
        );
      }
    });

    // Подписываемся на изменения статуса анимации
    animation.addStatusListener((status) {
      // Уничтожаем контроллер анимации при завершении анимации
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        animationController.dispose();
        // Обновляем карту в конце анимации
        if (isMounted) {
          _rebuildMap();
          loadSights();
        }
      }
    });

    // Запускаем анимацию
    animationController.forward();
  }

  /// Обновление карты.
  void _rebuildMap() {
    if (!_mapRebuilder.isClosed) {
      _mapRebuilder.sink.add(null);
    }
  }
}

/// Интерфейс WM.
abstract class IMapsScreenWidgetModel extends ICommonWidgetModel
    with ISightListWidgetModel {
  /// Последнее известное местоположение.
  Location? get lastLocation;

  /// URL для получения тайлов.
  String get mapUrl;

  /// Контроллер карт.
  MapController get mapController;

  /// Поток для перестроения карты.
  NullStream get mapRebuild;

  /// Состояние поиска текущего положения.
  ListenableEntityState<Location> get searchLocationState;

  /// Идентификтор выделенного места.
  ListenableState<Sight> get selectedSight;

  /// Показать текущее воложение на карте.
  Future<void> showCurrentLocation();

  /// Выделение мест на карте.
  void selectSight(Sight? sight);
}

/// Реализация WM по-умолчанию.
MapsScreenWM defaultMapsScreenWidgetModelFactory(BuildContext context) {
  final appDependencies = context.read<IAppScope>();

  final model = MapsScreenModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
    appDependencies.searchInteractor,
    appDependencies.settingsInteractor,
  );

  return MapsScreenWM(model);
}

/// Расширение для Location.
extension LocationExt on Location {
  LatLng get asLatLng {
    // Workaround: на сервере есть места с некорректными координатами
    final lat = latitude < -90.0 ? -90.0 : (latitude > 90.0 ? 90.0 : latitude);
    final lng =
        longitude < -180.0 ? -180.0 : (longitude > 180.0 ? 180.0 : longitude);

    return LatLng(lat, lng);
  }
}

/// Расширение для LatLng.
extension LatLngExt on LatLng {
  Location get asLocation => Location(
        latitude: latitude,
        longitude: longitude,
      );
}

typedef NullStream = Stream<void>;

extension ListenableStateExtension on ListenableState<Sight> {
  bool equalsById(Sight? other) => value?.id == other?.id;
}
