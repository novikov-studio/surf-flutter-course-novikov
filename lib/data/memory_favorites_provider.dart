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

  void _manage(String id, bool isLiked) {
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
