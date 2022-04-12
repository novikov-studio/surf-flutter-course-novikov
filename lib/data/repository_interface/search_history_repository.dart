import 'package:places/data/repository/memory_search_history_repository.dart';

/// Интерфейс для управления историей поиска.
abstract class SearchHistoryRepository {
  factory SearchHistoryRepository.getInstance() = MemorySearchHistoryRepository;

  /// Элементы должны быть отсортированы в порядке, обратном порядку добавления
  /// (последние добавленные - в начале списка)
  Future<List<String>> items();

  Future<void> add(String value);

  Future<void> remove(String value);

  Future<void> clear();
}
