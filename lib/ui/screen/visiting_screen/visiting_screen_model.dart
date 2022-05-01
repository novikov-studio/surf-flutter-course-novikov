import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/sight.dart';

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
