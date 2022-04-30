import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/sight.dart';

/// Модель экрана "Детализация".
class SightDetailsModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  SightDetailsModel(
    ErrorHandler errorHandler,
    this._placeInteractor,
  ) : super(errorHandler: errorHandler);

  /// Загрузка информации о достопримечательности.
  Future<Sight> load(int id) async {
    return _placeInteractor.getOne(id: id);
  }

  /// Добавление в Избранное.
  Future<Sight> addToFavorites(Sight sight) async {
    return _placeInteractor.addToFavorites(sight: sight);
  }

  /// Удаление из Избранного.
  Future<Sight> removeFromFavorites(Sight sight) async {
    return _placeInteractor.removeFromFavorites(sight: sight);
  }

  /// Запланировать.
  Future<Sight> schedule(Sight sight, DateTime planned) async {
    return _placeInteractor.schedule(sight: sight, planned: planned);
  }
}
