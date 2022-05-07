import 'package:places/domain/entity/sight.dart';

/// Интерфейс для управления списком Избранное.
abstract class FavoritesRepository {
  Future<Iterable<Sight>> items();

  Future<Sight?> getOne(int id);

  Future<void> add(Sight value);

  Future<void> remove(Sight value);

  Future<void> update(Sight value);

  /// Перемещает элемент с id=[sourceId] в позицию перед элементом с id=[insertBeforeId].
  /// Если [insertBeforeId] не указан, перемещает в конец списка.
  Future<void> reorder({required int sourceId, int? insertBeforeId});
}
