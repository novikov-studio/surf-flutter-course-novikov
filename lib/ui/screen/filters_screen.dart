import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

/// Экран "Фильтр".
class FiltersScreen extends StatefulWidget {
  final List<Sight> sights;

  const FiltersScreen({Key? key, required this.sights}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final currentLocation = mockCurrentLocation;

  RangeValues distance =
      const RangeValues(_SliderBar.minDistance, _SliderBar.maxDistance);

  List<Sight> filter = [];

  @override
  void initState() {
    super.initState();
    _updateFilter();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _FiltersAppBar(
        theme,
        onBackPressed: context.popScreen,
        onClearPressed: _onClear,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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

  void _updateFilter() {
    filter = widget.sights
        // Фильтр по расстоянию
        .where((sight) => Utils.isPointInRingArea(
              point: sight.location,
              center: currentLocation,
              minRadius: distance.start,
              maxRadius: distance.end,
            ))
        .toList(growable: false);
  }

  void _onApplyFilter() {
    // TODO(novikov): Возврат на предыдущий экран с применением фильтра
    final url = Utils.buildYandexMapsUrl(
      current: currentLocation,
      points: filter.map((e) => e.location),
    );

    launch(url);
  }

  void _onDistanceChange(RangeValues range) {
    setState(() {
      distance = range;
      _updateFilter();
    });
  }

  void _onClear() {
    setState(() {
      // TODO(novikov): Сбрасывать фильтры
    });
  }
}

/// AppBar с кнопками "Назад" и "Стереть".
class _FiltersAppBar extends AppBar {
  _FiltersAppBar(
    ThemeData theme, {
    VoidCallback? onBackPressed,
    VoidCallback? onClearPressed,
  }) : super(
          leading: IconButton(
            icon: const SvgIcon(AppIcons.arrow),
            splashRadius: 20.0,
            onPressed: onBackPressed,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: onClearPressed,
                child: const Text(AppStrings.clear),
                style: TextButton.styleFrom(
                  primary: theme.colorScheme.green,
                  textStyle: theme.textTheme.text,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ),
          ],
        );
}

/// Виджет выбора диапазона расстояния.
class _SliderBar extends StatelessWidget {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10; // км
  static const double stepDistance = 0.1; // км
  static const ticks = maxDistance / stepDistance - minDistance / stepDistance;

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
                Text(AppStrings.distance, style: theme.textOnBackground),
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
            divisions: ticks.toInt(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
