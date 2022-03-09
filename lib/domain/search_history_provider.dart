import 'package:flutter/foundation.dart';
import 'package:places/data/memory_search_history_provider.dart';

/// Интерфейс для управления историей поиска.
///
/// Позволяет подписаться на изменение истории.
abstract class SearchHistoryProvider implements Listenable {
  static SearchHistoryProvider createProvider() => MemorySearchHistoryProvider();

  /// Элементы должны быть отсортированы в порядке, обратном порядку добавления
  /// (последние добавленные - в начале списка)
  Future<Iterable<String>> items();

  Future<void> add(String value);

  Future<void> remove(String value);

  Future<void> clear();
}
