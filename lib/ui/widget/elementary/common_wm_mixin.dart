import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Миксин для WM с часто используемыми свойствами.
mixin CommonWMMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> implements ICommonWidgetModel {
  late ThemeData _theme;

  @override
  ThemeData get theme => _theme;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    super.didChangeDependencies();
  }
}

/// Интерфейс WM с часто используемыми свойствами.
abstract class ICommonWidgetModel extends IWidgetModel {
  /// Ссылка на текущую тему.
  ThemeData get theme;
}
