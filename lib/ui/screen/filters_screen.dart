import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/location.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/categories_grid.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/holders/locations.dart';
import 'package:places/ui/widget/holders/sights.dart';

/// Экран "Фильтр".
class FiltersScreen extends StatefulWidget {
  final Filter? initialValue;

  const FiltersScreen({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late final _DelayedSearch _delayedSearch;
  late Filter _filter;
  late Future<Iterable<Sight>> _search;

  @override
  void initState() {
    super.initState();

    _delayedSearch = _DelayedSearch(
      milliseconds: 1000,
      callback: () {
        setState(() {
          _search = _updateFilter();
        });
      },
    );

    if (widget.initialValue == null || widget.initialValue!.isEmpty) {
      _doClear();
    } else {
      _filter = widget.initialValue!;
    }
    _search = _updateFilter();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SimpleAppBar(
        leadingIcon: AppIcons.arrow,
        leadingOnTap: () => Navigator.pop(context),
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
          spacerH8,
          _SliderBar(
            range: RangeValues(_filter.minRadius!, _filter.maxRadius!),
            onChanged: _onDistanceChange,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: FutureBuilder<Iterable<Sight>>(
          future: _search,
          builder: (context, snapshot) {
            final isProgress = snapshot.connectionState != ConnectionState.done;
            final count = snapshot.hasData ? snapshot.data!.length : 0;

            return ElevatedButton(
              onPressed: count > 0 ? _onApplyFilter : null,
              child: isProgress
                  ? const Loader()
                  : Text(
                      AppStrings.showFilterResults(count),
                    ),
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 48.0),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Обработчик нажатия на кнопку "Показать".
  void _onApplyFilter() {
    Navigator.of(context).pop(_filter);
  }

  /// Обработчик переключения категорий.
  void _onCategoriesChange(String category, bool isChecked) {
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
      _doClear();
      _delayedSearch();
    });
  }

  /// Обновление фильтра.
  Future<Iterable<Sight>> _updateFilter() async {
    debugPrint('$_filter');
    final sightRepository = Sights.of(context)!;
    final location = await Locations.of(context)!.current();
    _filter = _filter.copyWith(location: location);

    return sightRepository.items(filter: _filter.copyWith(location: location));
  }

  /// Сброс фильтра.
  void _doClear() {
    _filter = Filter(
      categories: Categories.names.toSet(),
      minRadius: Filter.minDistance,
      maxRadius: Filter.maxDistance,
      location: const Location(longitude: 0, latitude: 0),
    );
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
