import 'package:flutter/cupertino.dart';
import 'package:places/domain/favorites_provider.dart';

/// Обеспечивает хранение экземпляра [FavoritesProvider] в дереве виджетов.
class Favorites extends InheritedWidget {
  final FavoritesProvider favoritesProvider;

  const Favorites({Key? key, required this.favoritesProvider, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is Favorites &&
        oldWidget.favoritesProvider != favoritesProvider;
  }

  /// Поиск экземпляра [FavoritesProvider] вверх по дереву.
  /// Опционально можно подписаться на изменение объекта.
  static FavoritesProvider? of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<Favorites>()
          ?.favoritesProvider;
    } else {
      final inheritedWidget =
          context.getElementForInheritedWidgetOfExactType<Favorites>()?.widget;

      return inheritedWidget is Favorites
          ? inheritedWidget.favoritesProvider
          : null;
    }
  }
}
