import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:places/domain/search_history_provider.dart';

/// Хранилище истории поиска в памяти.
///
/// Хранит не более [_maxSize] элементов.
/// При переполнении удаляет [_clearSize] наиболее старых элементов.
class MemorySearchHistoryProvider extends ChangeNotifier
    implements SearchHistoryProvider {
  static const int _maxSize = 20;
  static const int _clearSize = 1;
  static MemorySearchHistoryProvider? _instance;

  final List<String> _data = List.empty(growable: true);

  factory MemorySearchHistoryProvider() =>
      _instance ??= MemorySearchHistoryProvider._();

  MemorySearchHistoryProvider._();

  @override
  Future<Iterable<String>> items() async =>
      UnmodifiableListView(_data.reversed);

  @override
  Future<void> add(String value) async {
    final removed = _data.remove(value);
    if (!removed && _data.length >= _maxSize) {
      _data.removeRange(0, _clearSize);
    }
    _data.add(value);
    notifyListeners();
  }

  @override
  Future<void> remove(String value) async {
    _data.remove(value);
    notifyListeners();
  }

  @override
  Future<void> clear() async {
    _data.clear();
    notifyListeners();
  }
}
