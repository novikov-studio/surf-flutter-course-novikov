import 'package:places/data/database/database.dart';
import 'package:places/domain/repository/search_history_repository.dart';

/// Хранилище истории поиска в базе данных.
class DbSearchHistoryRepository implements SearchHistoryRepository {
  final Database _database;

  const DbSearchHistoryRepository(this._database);

  @override
  Future<List<String>> items() async =>
      _database.historyGetAll();

  @override
  Future<void> add(String value) async => _database.historyAdd(value);

  @override
  Future<void> remove(String value) async => _database.historyRemove(value);

  @override
  Future<void> clear() async => _database.historyClear();
}
