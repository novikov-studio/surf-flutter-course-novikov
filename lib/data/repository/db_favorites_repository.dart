import 'package:places/data/database/database.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/repository/favorites_repository.dart';

/// Менеджер списка Избранное.
class DbFavoritesRepository implements FavoritesRepository {
  final Database _database;

  const DbFavoritesRepository(this._database);

  @override
  Future<void> add(Sight value) async =>
      _database.favoritesAdd(SightMapper.toDbModel(value));

  @override
  Future<Iterable<Sight>> items() async {
    final res = await _database.favoritesGetAll();

    return res.map(SightMapper.fromDbModel);
  }

  @override
  Future<Sight?> getOne(int id) async {
    final res = await _database.favoritesGetOne(id);

    return res != null ? SightMapper.fromDbModel(res) : null;
  }

  @override
  Future<void> remove(Sight value) async => _database.favoritesRemove(value.id);

  @override
  Future<void> reorder({
    required int sourceId,
    int? insertBeforeId,
  }) async {
    // TODO(novikov): Реализовать хранение порядка в БД
  }

  @override
  Future<void> update(Sight value) async =>
      _database.favoritesUpdate(SightMapper.toDbModel(value));
}
