import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';

/// Виджет выбора диапазона расстояния.
class SliderBar extends StatelessWidget {
  static const double stepDistance = 0.1; // км
  static const int _ticks =
      (Filter.maxDistance - Filter.minDistance) ~/ stepDistance;

  final RangeValues range;
  final ValueChanged<RangeValues>? onChanged;

  const SliderBar({Key? key, required this.range, this.onChanged})
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
