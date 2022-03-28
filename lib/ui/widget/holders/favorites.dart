import 'package:flutter/material.dart';
import 'package:places/domain/favorites_provider.dart';
import 'package:places/ui/widget/holders/value_holder.dart';

/// Обеспечивает хранение экземпляра [FavoritesProvider] в дереве виджетов.
class Favorites extends ValueHolder<FavoritesProvider> {
  const Favorites({
    Key? key,
    required FavoritesProvider value,
    required Widget child,
  }) : super(
          key: key,
          value: value,
          child: child,
        );

  static FavoritesProvider? of(BuildContext context, {bool listen = false}) =>
      ValueHolder.of<Favorites, FavoritesProvider>(context, listen: listen);
}
