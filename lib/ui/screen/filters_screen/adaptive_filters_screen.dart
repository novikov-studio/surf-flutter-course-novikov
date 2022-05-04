import 'package:flutter/material.dart';
import 'package:places/ui/res/responsive.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';

/// Экран "Фильтры" с адаптацией к маленьким экранам.
class AdaptiveFiltersScreen extends StatelessWidget {
  const AdaptiveFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext _) =>
        const FiltersScreen();

    return HandsetAdapter(
      small: (_) => FontsSizeAdapter(
        factor: 1.4,
        builder: builder,
      ),
      orElse: builder,
    );
  }
}
