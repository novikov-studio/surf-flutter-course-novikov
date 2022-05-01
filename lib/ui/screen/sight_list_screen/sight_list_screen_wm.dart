import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';

/// WM для экрана "Список мест".
class SightListScreenWM
    extends WidgetModel<SightListScreen, SightListScreenModel>
    with CommonWMMixin<SightListScreen, SightListScreenModel>
    implements ISightListScreenWidgetModel {
  final _state = EntityStateNotifier<List<Sight>>();
  final _filterIsEmpty = StateNotifier<bool>();

  @override
  ListenableEntityState<List<Sight>> get sightsState => _state;

  @override
  ListenableState<bool> get filterIsEmpty => _filterIsEmpty;

  SightListScreenWM(SightListScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    loadSights(hidden: false);
  }

  @override
  Future<void> loadSights({bool hidden = true}) async {
    if (!hidden) {
      _state.loading(_state.value?.data);
    }

    try {
      final sights = await model.getSights();
      _state.content(sights);
    } on Exception catch (e) {
      _state.error(e);
    }
  }

  @override
  void showSearchDialog() {
    context.pushScreen(AppRoutes.search);
  }

  @override
  Future<void> showFilterDialog() async {
    final result = await context.pushScreen<Filter>(
      AppRoutes.filters,
      args: model.filter,
    );
    if (result != null) {
      _setFilter(result);
    }
  }

  @override
  Future<void> showAddDialog() async {
    final result = await context.pushScreen<bool>(AppRoutes.newSight);
    if (result ?? false) {
      await loadSights();
    }
  }

  /// Изменение фильтра.
  void _setFilter(Filter value) {
    try {
      model.filter = value;
      _filterIsEmpty.accept(value.isEmpty);
    } finally {
      loadSights();
    }
  }
}

/// Интерфейс WM.
abstract class ISightListScreenWidgetModel extends ICommonWidgetModel {
  /// Состояние загрузки списка места.
  ListenableEntityState<List<Sight>> get sightsState;

  /// Состояние фильтра (есть/нет).
  ListenableState<bool> get filterIsEmpty;

  /// Загрузка списка достопримечательностей.
  Future<void> loadSights({bool hidden = true});

  /// Переход на экран поиска.
  void showSearchDialog();

  /// Вызов диалога "Фильтры".
  Future<void> showFilterDialog();

  /// Вызов диалога "Новое место"
  Future<void> showAddDialog();
}

/// Реализация WM по-умолчанию.
SightListScreenWM defaultSightListScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = SightListScreenModel(
    appDependencies.errorHandler,
    appDependencies.placeInteractor,
    appDependencies.searchInteractor,
  );

  return SightListScreenWM(model);
}
