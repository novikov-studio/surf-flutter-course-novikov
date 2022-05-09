import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/geo_permissions_wm_mixin.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/sight_list_model_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';

/// Примесь для WM экранов "Список мест" и "Карта".
mixin SightListWMMixin<W extends ElementaryWidget, M extends SightListModel>
    on WidgetModel<W, M> implements ISightListWidgetModel, IGeoPermissionsWidgetModel  {
  final _state = EntityStateNotifier<List<Sight>>();
  final _filterIsEmpty = StateNotifier<bool>();

  @override
  ListenableEntityState<List<Sight>> get sightsState => _state;

  @override
  ListenableState<bool> get filterIsEmpty => _filterIsEmpty;

  bool get autoLoadSight => true;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _filterIsEmpty.accept(model.filter.isEmpty);
    if (autoLoadSight) {
      loadSights(hidden: false);
    }
  }

  @override
  Future<void> loadSights({bool hidden = true}) async {
    if (model.filter.hasDistance) {
      await checkGeoPermissions();
    }

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

/// Примесь для интерфейса WM.
mixin ISightListWidgetModel {
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
