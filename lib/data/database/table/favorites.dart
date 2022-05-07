import 'package:drift/drift.dart';
import 'package:places/data/database/database.dart';

/// Таблица "Избранное"
@DataClassName('Favorite')
class Favorites extends Table {
  @override
  Set<Column>? get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get name => text()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  TextColumn get urls => text()();

  TextColumn get info => text().nullable()();

  TextColumn get details => text().nullable()();

  TextColumn get category => text()();

  DateTimeColumn get plannedDate => dateTime().nullable()();

  DateTimeColumn get visitedDate => dateTime().nullable()();
}

/// Миксин с методами для работы с таблицей "Избранное".
mixin FavoritesMixin {
  Database get db;

  /// Получение всех записей.
  Future<Iterable<Favorite>> favoritesGetAll() async {
    final dbRequest = db.select(db.favorites)
      ..orderBy(
        [
          (t) => OrderingTerm.desc(t.rowId),
        ],
      );

    return dbRequest.get();
  }

  /// Запрос одной записи.
  Future<Favorite?> favoritesGetOne(int id) async =>
      (db.favorites.select()..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

  /// Добавление новой записи.
  Future<void> favoritesAdd(Favorite value) async => db.favorites.insertOne(
        value,
        mode: InsertMode.insertOrIgnore,
      );

  /// Обновление записи.
  Future<void> favoritesUpdate(Favorite value) async =>
      db.favorites.update().replace(value);

  /// Удаление записи.
  Future<void> favoritesRemove(int id) async =>
      db.favorites.deleteWhere((tbl) => tbl.id.equals(id));
}
