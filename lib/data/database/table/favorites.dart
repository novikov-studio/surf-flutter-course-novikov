import 'package:drift/drift.dart';
import 'package:places/data/database/database.dart';

/// Таблица "Избранное"
@DataClassName('Favorite')
class Favorites extends Table {
  IntColumn get id => integer().unique()();
  TextColumn get description => text()();
}

/// Миксин с методами для работы с таблицей "Избранное".
mixin FavoritesMixin on Database {

}