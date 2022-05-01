import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/interactor/place_interactor.dart';

/// Модель экрана "Новое место".
class AddSightScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  AddSightScreenModel(
    this._placeInteractor,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Добавление нового места.
  Future<bool> addSight(Sight sight) async {
    try {
      await _placeInteractor.addNew(sight: sight);

      return true;
    } on Exception catch (e) {
      handleError(e);

      return false;
    }
  }
}
