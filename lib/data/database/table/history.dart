import 'package:drift/drift.dart';
import 'package:places/data/database/database.dart';

/// Таблица "История поиска".
@DataClassName('HistoryEntry')
class History extends Table {
  TextColumn get pattern => text().unique()();

  @override
  bool get withoutRowId => true;
}

/// Миксин для работы с таблицей "История поиска".
mixin HistoryMixin {
  Database get db;

  /// Получение всех записей.
  Future<List<String>> historyGetAll() async {
    final res = await db.select(db.history).get();

    return res.map((e) => e.pattern).toList();
  }

  /// Добавление новой записи.
  Future<void> historyAdd(String pattern) async {
    await db.history.insertOne(
      HistoryCompanion.insert(pattern: pattern),
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Удаление записи.
  Future<void> historyRemove(String pattern) async {
    await db.history.deleteWhere((tbl) => tbl.pattern.equals(pattern));
  }

  /// Очистка таблицы.
  Future<void> historyClear() async {
    await db.history.delete().go();
  }
}
