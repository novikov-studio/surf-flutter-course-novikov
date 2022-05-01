import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/logger.dart';
import 'package:places/ui/screen/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_model.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Избранное".
class VisitingScreenWM extends WidgetModel<VisitingScreen, VisitingScreenModel>
    implements IVisitingScreenWidgetModel {
  final _state = EntityStateNotifier<Iterable<Sight>>();

  @override
  ListenableEntityState<Iterable<Sight>> get sightState => _state;

  VisitingScreenWM(VisitingScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    load(hidden: false);
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  Future<void> reorder(int sourceId, int? insertBeforeId) async {
    try {
      await model.reorderInFavorites(
        sourceId: sourceId,
        insertBeforeId: insertBeforeId,
      );
    } on Exception catch (e) {
      onErrorHandle(e);
    } finally {
      await load();
    }
  }

  @override
  Future<void> load({bool hidden = true}) async {
    try {
      if (!hidden) {
        _state.loading();
      }

      final sights = await model.loadFavorites();
      _state.content(sights);
    } on Exception catch (e) {
      _state.error(e);
    }
  }
}

/// Интерфейс WM.
abstract class IVisitingScreenWidgetModel extends IWidgetModel {
  /// Состояние загрузки списка Ищбранное.
  ListenableEntityState<Iterable<Sight>> get sightState;

  /// Загрузка списка Ищбранное.
  Future<void> load({bool hidden = true});

  /// Ручная сортировка списка Избранное.
  Future<void> reorder(int sourceId, int? insertBeforeId);
}

/// Реализация WM по-умолчанию.
VisitingScreenWM defaultVisitingScreenWidgetModelFactory(BuildContext context) {
  final appDependencies = context.read<IAppScope>();

  final model = VisitingScreenModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
  );

  return VisitingScreenWM(model);
}
