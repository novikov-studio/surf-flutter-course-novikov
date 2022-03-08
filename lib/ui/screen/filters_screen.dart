import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/service/location.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/categories_grid.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/simple_app_bar.dart';

/// Экран "Фильтр".
class FiltersScreen extends StatefulWidget {
  final List<Sight> sights;
  final void Function(List<Sight> filtered) onApplyFilter;

  const FiltersScreen({
    Key? key,
    required this.sights,
    required this.onApplyFilter,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final Location currentLocation = mockCurrentLocation;

  // Список выбранных категорий
  final Set<String> categories = {};

  // Выбранный диапазон расстояний
  RangeValues distance =
      const RangeValues(_SliderBar.minDistance, _SliderBar.maxDistance);

  // Список мест, удовлетворяющих фильтру
  List<Sight> filter = [];

  @override
  void initState() {
    super.initState();
    _doClear();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CategoriesGrid(
              checked: categories,
              onCategoryPressed: _onCategoriesChange,
            ),
          ),
          spacerH8,
          _SliderBar(
            range: distance,
            onChanged: _onDistanceChange,
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: filter.isNotEmpty ? _onApplyFilter : null,
              child: Text(
                AppStrings.showFilterResults(filter.length),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Обработчик нажатия на кнопку "Показать".
  void _onApplyFilter() {
    widget.onApplyFilter(filter);
  }

  /// Обработчик переключения категорий.
  void _onCategoriesChange(String category, bool isChecked) {
    setState(() {
      isChecked ? categories.add(category) : categories.remove(category);
      _updateFilter();
    });
  }

  /// Обработчик изменения позиции слайдеров.
  void _onDistanceChange(RangeValues range) {
    setState(() {
      distance = range;
      _updateFilter();
    });
  }

  /// Обработчик нажатия на кнопку "Очистить".
  void _onClear() {
    setState(_doClear);
  }

  /// Обновление фильтра.
  void _updateFilter() {
    filter = widget.sights
        // Фильтр по категории
        .where((sight) => categories.contains(sight.type))
        // Фильтр по расстоянию
        .where((sight) => Utils.isPointInRingArea(
              point: sight.location,
              center: currentLocation,
              minRadius: distance.start,
              maxRadius: distance.end,
            ))
        .toList(growable: false);
  }

  /// Сброс фильтра.
  void _doClear() {
    // Включаем все категории
    categories.addAll(Categories.names);
    // Устанавливаем максимальный диапазон расстояния
    distance =
        const RangeValues(_SliderBar.minDistance, _SliderBar.maxDistance);
    // Обновляем список мест, удовлетворяющих фильтру
    _updateFilter();
  }
}

/// Виджет выбора диапазона расстояния.
class _SliderBar extends StatelessWidget {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10.0; // км
  static const double stepDistance = 0.1; // км
  static const int _ticks = (maxDistance - minDistance) ~/ stepDistance;

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
            min: minDistance,
            max: maxDistance,
            divisions: _ticks,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
