import 'dart:_internal';

import 'package:places/data/repository_interface/favorites_repository.dart';
import 'package:places/domain/sight.dart';

/// Менеджер списка Избранное на моковых данных.
class MemoryFavoritesRepository implements FavoritesRepository {
  final List<Sight> _items = <Sight>[];

  @override
  Future<void> add(Sight value) async {
    _items.add(value);
  }

  @override
  Future<Iterable<Sight>> items() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> remove(Sight value) async {
    _items.removeWhere((element) => element.id == value.id);
  }

  @override
  Future<void> reorder({
    required String sourceId,
    String? insertBeforeId,
  }) async {
    final sourceIndex = _items.indexWhere((element) => element.id == sourceId);
    final targetIndex = insertBeforeId != null
        ? _items.indexWhere((element) => element.id == insertBeforeId)
        : null;
    assert(sourceIndex >= 0 || (targetIndex ?? 0) >= 0);

    if (sourceIndex >= 0 && sourceIndex != targetIndex) {
      final sight = _items.removeAt(sourceIndex);
      if (targetIndex == null) {
        _items.add(sight);
      } else {
        if (targetIndex >= 0) {
          _items.insert(targetIndex, sight);
        }
      }
    }
  }

  @override
  Future<void> update(Sight value) async {
    final index = _items.indexWhere((element) => element.id == value.id);
    if (index < 0) {
      throw IterableElementError.noElement();
    }

    _items
      ..removeAt(index)
      ..insert(index, value);
  }
}
