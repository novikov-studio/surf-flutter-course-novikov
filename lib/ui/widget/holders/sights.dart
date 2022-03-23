import 'package:flutter/material.dart';
import 'package:places/domain/sight_repository.dart';
import 'package:places/ui/widget/holders/value_holder.dart';

/// Обеспечивает хранение экземпляра [SightRepository] в дереве виджетов.
class Sights extends ValueHolder<SightRepository> {
  const Sights({
    Key? key,
    required SightRepository value,
    required Widget child,
  }) : super(
          key: key,
          value: value,
          child: child,
        );

  static SightRepository? of(BuildContext context) =>
      ValueHolder.of<Sights, SightRepository>(context);
}
