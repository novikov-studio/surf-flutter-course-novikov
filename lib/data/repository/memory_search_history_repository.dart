import 'dart:collection';

import 'package:places/data/repository_interface/search_history_repository.dart';

/// Хранилище истории поиска в памяти.
///
/// Хранит не более [_maxSize] элементов.
/// При переполнении удаляет [_clearSize] наиболее старых элементов.
class MemorySearchHistoryRepository implements SearchHistoryRepository {
  static const int _maxSize = 20;
  static const int _clearSize = 1;
  final List<String> _data = <String>[];

  @override
  Future<List<String>> items() async =>
      UnmodifiableListView(_data.reversed);

  @override
  Future<void> add(String value) async {
    final removed = _data.remove(value);
    if (!removed && _data.length >= _maxSize) {
      _data.removeRange(0, _clearSize);
    }
    _data.add(value);
  }

  @override
  Future<void> remove(String value) async {
    _data.remove(value);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }
}
