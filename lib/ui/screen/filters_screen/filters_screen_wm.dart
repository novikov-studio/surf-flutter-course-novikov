import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/res/app_scope.dart';
import 'package:places/ui/res/context_extension.dart';
import 'package:places/ui/res/logger.dart';
import 'package:places/ui/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_model.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/geo_permissions_wm_mixin.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// WM для экрана "Фильтры".
class FiltersScreenWM extends WidgetModel<FiltersScreen, FiltersScreenModel>
    with CommonWMMixin, GeoPermissionsWMMixin
    implements IFiltersScreenWidgetModel {
  /// Фильтр по-умолчанию.
  static final _defaultFilter = Filter(
    categories: Category.values.toSet(),
    minRadius: Filter.minDistance,
    maxRadius: Filter.maxDistance,
  );

  /// Фильтр.
  final _categories = StateNotifier<Set<Category>>();
  final _minRadius = StateNotifier<double>();
  final _maxRadius = StateNotifier<double>();

  /// Результат фильтра.
  final _foundCount = EntityStateNotifier<int>();

  /// Контроллер поиска.
  final _searchController = StreamController<Filter>();

  /// Публичные свойства
  @override
  ListenableState<Set<Category>> get categories => _categories;

  @override
  ListenableState<double> get minRadius => _minRadius;

  @override
  ListenableState<double> get maxRadius => _maxRadius;

  @override
  ListenableEntityState<int> get foundCount => _foundCount;

  @override
  double get loaderSize => _loaderSize;

  /// Служебные поля.
  late Filter _result;
  late double _loaderSize;

  Filter get _filter => Filter(
        categories: _categories.value,
        minRadius: _minRadius.value,
        maxRadius: _maxRadius.value,
      );

  /// Конструктор.
  FiltersScreenWM(FiltersScreenModel model, Filter initialValue)
      : _result = initialValue,
        super(model) {
    _categories.accept(initialValue.categories ?? _defaultFilter.categories);
    _minRadius.accept(initialValue.minRadius ?? _defaultFilter.minRadius);
    _maxRadius.accept(initialValue.maxRadius ?? _defaultFilter.maxRadius);
    _categories.addListener(_delayedSearch);
    _minRadius.addListener(_delayedSearch);
    _maxRadius.addListener(_delayedSearch);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    // Отложенный поиск с задержкой в 1 сек.
    _searchController.stream
        .debounceTime(const Duration(milliseconds: 1000))
        .distinct()
        .listen(_instantSearch);
  }

  @override
  void didChangeDependencies() {
    // Чтобы не ограничивать кнопки по высоте, приходится рассчитывать размера лоадера,
    // чтобы высота кнопки не "плясала" при смене текст/лоадер.
    _loaderSize = Loader.calcSizeForButton(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.close();
    super.dispose();
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  void back() {
    Navigator.of(context).pop(_result);
  }

  @override
  Future<bool> onWilPopup() async {
    back();

    return true;
  }

  @override
  void toggleCategory(Category category) {
    final items = _categories.value?.toSet();

    items?.contains(category) ?? false
        ? items?.remove(category)
        : items?.add(category);

    _categories.accept(items);
  }

  @override
  void onDistanceChange(RangeValues values) {
    _minRadius.accept(values.start);
    _maxRadius.accept(values.end);
  }

  @override
  void clearFilter() {
    _result = const Filter();
    _categories.accept(_defaultFilter.categories);
    _minRadius.accept(_defaultFilter.minRadius);
    _maxRadius.accept(_defaultFilter.maxRadius);
  }

  @override
  void applyFilter() {
    _result = _filter;
    back();
  }

  /// Отложенный поиск.
  ///
  /// Вызывается при каждом изменении фильтра.
  void _delayedSearch() {
    _searchController.sink.add(_filter);
  }

  /// Выполнение поиска с отображением в UI.
  Future<void> _instantSearch(Filter filter) async {
    if (filter.hasDistance) {
      await checkGeoPermissions();
    }

    _foundCount.loading();
    try {
      final count = await model.findCountByFilter(filter);
      _foundCount.content(count);
    } on Object catch (e) {
      _foundCount.error(null, 0);
      onErrorHandle(e);
    }
  }
}

/// Интерфейс WM.
abstract class IFiltersScreenWidgetModel extends ICommonWidgetModel {
  /// Список выбранных категорий.
  ListenableState<Set<Category>> get categories;

  /// Минимальный радиус.
  ListenableState<double> get minRadius;

  /// Максимальный радиус.
  ListenableState<double> get maxRadius;

  /// Состояние поиска.
  ListenableEntityState<int> get foundCount;

  /// Размер индикатора прогресса.
  double get loaderSize;

  /// Возврат на предыдущий экран.
  void back();

  /// Обработчик нажатия на аппаратную кнопку "Назад".
  Future<bool> onWilPopup();

  /// Обработчик изменения слайдеров расстояния.
  void onDistanceChange(RangeValues values);

  /// Обработчик нажатий на иконки категорий.
  void toggleCategory(Category category);

  /// Сброс фильтра.
  void clearFilter();

  /// Применение фильтра.
  void applyFilter();
}

/// Реализация WM по-умолчанию.
FiltersScreenWM defaultFiltersScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final initialValue = context.routeArgs<Filter>()!;

  final model = FiltersScreenModel(
    appDependencies.placeInteractor,
    appDependencies.errorHandler,
  );

  return FiltersScreenWM(model, initialValue);
}
