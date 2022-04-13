import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/categories_grid.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:provider/provider.dart';

/// Экран "Фильтр".
class FiltersScreen extends StatelessWidget {
  final Filter initialValue;

  const FiltersScreen({Key? key, required this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext _) =>
        _FiltersScreen(initialValue: initialValue);

    return HandsetAdapter(
      small: (_) => FontsSizeAdapter(
        factor: 1.4,
        builder: builder,
      ),
      orElse: builder,
    );
  }
}

/// Кнопка Очистить задает значение фильтра по-умолчанию.
/// Однако оно используется только при нажатии кнопки ПОКАЗАТЬ.
///
/// Если после нажатия Очистить вернуться на главный экран
/// с помощью программной или аппаратной кнопки Назад
/// филььр будет сброшен.
class _FiltersScreen extends StatefulWidget {
  final Filter initialValue;

  const _FiltersScreen({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<_FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<_FiltersScreen> {
  late final _DelayedSearch _delayedSearch;
  late Filter _filter;
  late double _loaderSize;
  late Future<int> _search;

  /// Фильтр по-умолчанию.
  Filter get _defaultFilter => Filter(
        categories: Category.values.toSet(),
        minRadius: Filter.minDistance,
        maxRadius: Filter.maxDistance,
      );

  @override
  void initState() {
    super.initState();

    // Отложенный поиск для сокращения кол-ва обращений к серверу
    _delayedSearch = _DelayedSearch(
      milliseconds: 1000,
      callback: () {
        setState(() {
          _search = _updateFilter();
        });
      },
    );

    final def = _defaultFilter;

    _filter = Filter(
      categories: widget.initialValue.categories ?? def.categories,
      minRadius: widget.initialValue.minRadius ?? def.minRadius,
      maxRadius: widget.initialValue.maxRadius ?? def.maxRadius,
    );

    // Запуск поиска подходящих мест
    _search = _updateFilter();
  }

  @override
  void didChangeDependencies() {
    // Чтобы не ограничивать кнопки по высоте, приходится рассчитывать размера лоадера,
    // чтобы высота кнопки не "плясала" при смене текст/лоадер.
    _loaderSize = Loader.calcSizeForButton(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(novikov): Оптимизировать верстку - уйти от глобального setState
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        _back();

        return false;
      },
      child: Scaffold(
        appBar: SimpleAppBar(
          leadingIcon: AppIcons.arrow,
          leadingOnTap: _back,
          trailingText: AppStrings.clear,
          trailingOnTap: _onClear,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Text(
                AppStrings.categories,
                style: theme.superSmallInactiveBlack,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CategoriesGrid(
                  checked: _filter.categories!,
                  onCategoryPressed: _onCategoriesChange,
                ),
              ),
            ),
            spacerH24,
            _SliderBar(
              range: RangeValues(_filter.minRadius!, _filter.maxRadius!),
              onChanged: _onDistanceChange,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: FutureBuilder<int>(
            future: _search,
            builder: (context, snapshot) {
              final isProgress =
                  snapshot.connectionState != ConnectionState.done;
              final count = snapshot.hasData ? snapshot.data! : 0;

              return ElevatedButton(
                onPressed: count > 0 ? _onApplyFilter : null,
                child: isProgress
                    ? Loader(size: _loaderSize)
                    : Text(
                        AppStrings.showFilterResults(count),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Обработчик нажатия на кнопку "Показать".
  void _onApplyFilter() {
    Navigator.of(context).pop(_filter);
  }

  /// Обработчик переключения категорий.
  void _onCategoriesChange(Category category, bool isChecked) {
    setState(() {
      isChecked
          ? _filter.categories!.add(category)
          : _filter.categories!.remove(category);
      _delayedSearch();
    });
  }

  /// Обработчик изменения позиции слайдеров.
  void _onDistanceChange(RangeValues range) {
    setState(() {
      _filter = _filter.copyWith(minRadius: range.start, maxRadius: range.end);
      _delayedSearch();
    });
  }

  /// Обработчик нажатия на кнопку "Очистить".
  void _onClear() {
    setState(() {
      _filter = _defaultFilter;
      _delayedSearch();
    });
  }

  /// Обновление фильтра.
  Future<int> _updateFilter() async {
    final placeInteractor = context.read<PlaceInteractor>();
    final found = await placeInteractor.getAll(
      categories: _filter.categories,
      maxRadius: _filter.maxRadius,
      minRadius: _filter.minRadius,
    );

    return found.length;
  }

  void _back() {
    // Если фильтр по-умолчанию, то возвращаем пустой фильтр
    final result = _filter == _defaultFilter ? const Filter() : _filter;
    Navigator.of(context).pop(result);
  }
}

/// Виджет выбора диапазона расстояния.
class _SliderBar extends StatelessWidget {
  static const double stepDistance = 0.1; // км
  static const int _ticks =
      (Filter.maxDistance - Filter.minDistance) ~/ stepDistance;

  final RangeValues range;
  final ValueChanged<RangeValues>? onChanged;

  const _SliderBar({Key? key, required this.range, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.distance, style: theme.text400OnBackground),
                Text(
                  AppStrings.distanceRange(range.start, range.end),
                  style: theme.text400Secondary2,
                ),
              ],
            ),
          ),
          RangeSlider(
            values: range,
            min: Filter.minDistance,
            max: Filter.maxDistance,
            divisions: _ticks,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Класс для задержки реакции на изменение.
class _DelayedSearch {
  final VoidCallback callback;
  final Duration _delay;
  Timer? _timer;

  _DelayedSearch({
    required int milliseconds,
    required this.callback,
  }) : _delay = Duration(milliseconds: milliseconds);

  void call() {
    _timer?.cancel();
    _timer = Timer(_delay, callback);
  }

  void cancel() {
    _timer?.cancel();
  }

  void dispose() {
    cancel();
  }
}
