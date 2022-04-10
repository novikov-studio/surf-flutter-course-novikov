import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:places/domain/favorites_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

/// Менеджер списка Избранное на моковых данных.
class MemoryFavoritesProvider extends ChangeNotifier
    implements FavoritesProvider {
  @override
  Future<Iterable<Sight>> items() async =>
      UnmodifiableListView(mocks.where((element) => element.isLiked));

  @override
  Future<void> add(Sight value) async {
    _manage(value.id, true);
  }

  @override
  Future<void> remove(Sight value) async {
    _manage(value.id, false);
  }

  @override
  Future<void> reorder({required int sourceId, int? insertBeforeId}) async {
    final sourceIndex = mocks.indexWhere((element) => element.id == sourceId);
    final targetIndex = insertBeforeId != null
        ? mocks.indexWhere((element) => element.id == insertBeforeId)
        : null;
    assert(sourceIndex >= 0 || (targetIndex ?? 0) >= 0);

    if (sourceIndex >= 0 && sourceIndex != targetIndex) {
      final sight = mocks.removeAt(sourceIndex);
      if (targetIndex == null) {
        mocks.add(sight);
        notifyListeners();
      } else {
        if (targetIndex >= 0) {
          mocks.insert(targetIndex, sight);
          notifyListeners();
        }
      }
    }
  }

  void _manage(int id, bool isLiked) {
    final index = mocks.indexWhere((element) => element.id == id);
    if (index >= 0 && mocks[index].isLiked != isLiked) {
      final clone = mocks[index].copyWith(isLiked: isLiked);
      mocks
        ..removeAt(index)
        ..insert(index, clone);
      notifyListeners();
    }
  }
}
