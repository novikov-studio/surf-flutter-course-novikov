import 'package:places/data/database/database.dart';
import 'package:places/domain/repository/search_history_repository.dart';

/// Хранилище истории поиска в базе данных.
///
/// Хранит всю историю, но отображает [_maxSize] последних элементов.
class DbSearchHistoryRepository implements SearchHistoryRepository {
  static const int _maxSize = 20;

  final Database _database;

  const DbSearchHistoryRepository(this._database);

  @override
  Future<List<String>> items() async =>
      _database.historyGetAll(limit: _maxSize);

  @override
  Future<void> add(String value) async => _database.historyAdd(value);

  @override
  Future<void> remove(String value) async => _database.historyRemove(value);

  @override
  Future<void> clear() async => _database.historyClear();
}
