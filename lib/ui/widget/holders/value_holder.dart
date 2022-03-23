import 'package:flutter/material.dart';

/// Обеспечивает хранение экземпляра [T] в дереве виджетов.
class ValueHolder<T> extends InheritedWidget {
  final T value;

  const ValueHolder({Key? key, required this.value, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is ValueHolder<T> && oldWidget.value != value;
  }

  /// Поиск экземпляра [ValueHolder] вверх по дереву.
  /// Опционально можно подписаться на изменение объекта.
  static R? of<V extends InheritedWidget, R>(
    BuildContext context, {
    bool listen = false,
  }) {
    final inheritedWidget = listen
        ? context.dependOnInheritedWidgetOfExactType<V>()
        : context.getElementForInheritedWidgetOfExactType<V>()?.widget;

    return inheritedWidget is ValueHolder ? inheritedWidget.value as R : null;
  }
}
