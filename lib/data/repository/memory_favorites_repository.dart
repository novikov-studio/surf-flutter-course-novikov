import 'dart:collection';

import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/repository/favorites_repository.dart';

/// Менеджер списка Избранное на моковых данных.
class MemoryFavoritesRepository implements FavoritesRepository {
  final List<Sight> _items = <Sight>[];

  @override
  Future<void> add(Sight value) async {
    final index = _items.indexWhere((element) => element.id == value.id);
    if (index < 0) {
      _items.add(value);
    }
  }

  @override
  Future<Iterable<Sight>> items() async {
    return UnmodifiableListView(_items);
  }

  @override
  Future<void> remove(Sight value) async {
    _items.removeWhere((element) => element.id == value.id);
  }

  @override
  Future<void> reorder({
    required int sourceId,
    int? insertBeforeId,
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
      throw Exception('Not Found');
    }

    _items
      ..removeAt(index)
      ..insert(index, value);
  }
}
