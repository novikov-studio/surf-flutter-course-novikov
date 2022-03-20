import 'package:flutter/material.dart';
import 'package:places/domain/location_provider.dart';
import 'package:places/ui/widget/holders/value_holder.dart';

/// Обеспечивает хранение экземпляра [LocationProvider] в дереве виджетов.
class Locations extends ValueHolder<LocationProvider> {
  const Locations({
    Key? key,
    required LocationProvider value,
    required Widget child,
  }) : super(
    key: key,
    value: value,
    child: child,
  );

  static LocationProvider? of(BuildContext context) =>
      ValueHolder.of<Locations, LocationProvider>(context);
}
