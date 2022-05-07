import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/table/favorites.dart';
import 'package:places/data/database/table/history.dart';

part '../../gen/data/database/database.g.dart';

@DriftDatabase(tables: [History, Favorites])
class Database extends _$Database with HistoryMixin, FavoritesMixin {
  @override
  int get schemaVersion => 1;

  @override
  Database get db => this;

  Database() : super(_openConnection());
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
