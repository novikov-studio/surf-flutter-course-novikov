import 'package:elementary/elementary.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/mixins/sight_model_mixin.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_wm.dart';
import 'package:places/ui/widget/controls/date_time_picker.dart';
import 'package:provider/provider.dart';

/// Примесь для виджет-моделей с методами для работы с [Sight].
mixin SightWMMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> {
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
}
