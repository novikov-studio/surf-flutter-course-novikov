import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widget/holders/value_holder.dart';

/// Обеспечивает хранение экземпляра [Sight] в дереве виджетов.
///
/// Перестраивает дочерние виджеты при изменении значения.
class SightHolder extends ValueHolder<ValueNotifier<Sight>> {
  SightHolder({
    Key? key,
    required ValueNotifier<Sight> value,
    required Widget Function(BuildContext context, Sight value) builder,
  }) : super(
          key: key,
          value: value,
          child: AnimatedBuilder(
            animation: value,
            builder: (context, __) => builder(context, value.value),
          ),
        );

  static ValueNotifier<Sight>? of(BuildContext context) =>
      ValueHolder.of<SightHolder, ValueNotifier<Sight>>(context);
}
