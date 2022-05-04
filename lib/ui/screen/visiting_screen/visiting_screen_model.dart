import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/interactor/place_interactor.dart';

/// Модель экрана "Избранное".
class VisitingScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  VisitingScreenModel(
    ErrorHandler errorHandler,
    this._placeInteractor,
  ) : super(errorHandler: errorHandler);

  Future<void> reorderInFavorites({
    required int sourceId,
    int? insertBeforeId,
  }) =>
      _placeInteractor.reorderInFavorites(
        sourceId: sourceId,
        insertBeforeId: insertBeforeId,
      );

  Future<Iterable<Sight>> loadFavorites() async =>
      _placeInteractor.getFavorites();
}
