import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/sight_card/mixin/sight_model_mixin.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_wm.dart';
import 'package:places/ui/widget/date_time_picker.dart';
import 'package:provider/provider.dart';

/// Примесь для виджет-моделей с методами для работы с [Sight].
mixin SightWMMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> {
  /// Приоритет программ-навигаторов.
  ///
  /// Если установленно несколько программ,
  /// запускается программа с наивысшим приоритетом.
  static const _mapPriority = <MapType, int>{
    MapType.yandexNavi: 10,
    MapType.google: 9,
    MapType.apple: 8,
    MapType.yandexMaps: 7,
  };

  /// Переключить флаг "В Избранном".
  Future<void> internalToggleInFavorites(
    StateNotifier<Sight> sightState,
    SightModelMixin model,
  ) async {
    try {
      final visitingWM = context.read<IVisitingScreenWidgetModel?>();

      final sight = sightState.value;
      if (sight != null) {
        final newSight = sight.isLiked
            ? await model.removeFromFavorites(sight)
            : await model.addToFavorites(sight);

        // Обновляем текущий экран, если требуется
        visitingWM != null && !newSight.isLiked
            ? visitingWM.load()
            : sightState.accept(newSight);
      }
    } on Object catch (e) {
      onErrorHandle(e);
    }
  }

  /// Запланировать посещение.
  Future<void> internalPlanVisiting(
    StateNotifier<Sight> sightState,
    SightModelMixin model,
  ) async {
    try {
      final sight = sightState.value;
      if (sight != null) {
        final plannedDate =
            await DateTimePicker.show(context, initial: sight.plannedDate);
        if (plannedDate != null) {
          final newSight = await model.schedule(sight, plannedDate);
          sightState.accept(newSight);
        }
      }
    } on Object catch (e) {
      onErrorHandle(e);
    }
  }

  /// Пометить как посещенное.
  Future<void> internalVisited(
    StateNotifier<Sight> sightState,
    SightModelMixin model,
  ) async {
    try {
      final sight = sightState.value;
      if (sight != null) {
        final newSight = await model.visit(sight);
        sightState.accept(newSight);
      }
    } on Object catch (e) {
      onErrorHandle(e);
    }
  }

  /// Построить маршрут.
  Future<void> internalGoRoute({
    Location? fromPoint,
    required Location toPoint,
    String? toTitle,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final availableMaps = await MapLauncher.installedMaps;

    if (availableMaps.isEmpty) {
      scaffoldMessenger.showError(AppStrings.navigationAppNotFound);

      return;
    }

    availableMaps.sort(
      (a, b) => (_mapPriority[b.mapType] ?? 0).compareTo(
        _mapPriority[a.mapType] ?? 0,
      ),
    );

    await availableMaps.first.showDirections(
      origin: fromPoint != null
          ? Coords(
              fromPoint.latitude,
              fromPoint.longitude,
            )
          : null,
      destination: Coords(toPoint.latitude, toPoint.longitude),
      destinationTitle: toTitle,
    );
  }
}
