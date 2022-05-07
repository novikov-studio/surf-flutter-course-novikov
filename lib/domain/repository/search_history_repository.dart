/// Интерфейс для управления историей поиска.
abstract class SearchHistoryRepository {
  /// Элементы должны быть отсортированы в порядке, обратном порядку добавления
  /// (последние добавленные - в начале списка)
  ///
  /// Позволяет запросить все элементы, либо [lastCount] последних элементов.
  Future<List<String>> items({int? lastCount});

  Future<void> add(String value);

  Future<void> remove(String value);

  Future<void> clear();
}
