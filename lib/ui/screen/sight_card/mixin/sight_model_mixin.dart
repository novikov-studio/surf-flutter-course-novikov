import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/interactor/place_interactor.dart';

/// Примесь для моделей, работающих с [Sight].
mixin SightModelMixin {
  late final PlaceInteractor placeInteractor;

  /// Добавление в Избранное.
  Future<Sight> addToFavorites(Sight sight) async {
    return placeInteractor.addToFavorites(sight: sight);
  }

  /// Удаление из Избранного.
  Future<Sight> removeFromFavorites(Sight sight) async {
    return placeInteractor.removeFromFavorites(sight: sight);
  }

  /// Запланировать.
  Future<Sight> schedule(Sight sight, DateTime planned) async {
    return placeInteractor.schedule(sight: sight, planned: planned);
  }

  /// Загрузка информации о достопримечательности.
  Future<Sight> load(int id) async {
    return placeInteractor.getOne(id: id);
  }
}
