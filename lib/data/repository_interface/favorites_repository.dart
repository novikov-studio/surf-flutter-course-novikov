import 'package:flutter/foundation.dart';
import 'package:places/domain/sight.dart';

/// Интерфейс для управления списком Избранное.
///
/// Позволяет подписаться на изменение списка.
abstract class FavoritesRepository implements Listenable {
  Future<Iterable<Sight>> items();

  Future<void> add(Sight value);

  Future<void> remove(Sight value);

  Future<void> update(Sight value);

  /// Перемещает элемент с id=[sourceId] в позицию перед элементом с id=[insertBeforeId].
  /// Если [insertBeforeId] не указан, перемещает в конец списка.
  Future<void> reorder({required String sourceId, String? insertBeforeId});
}
