import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/interactor/place_interactor.dart';

/// Модель экрана "Фильтры".
class FiltersScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;

  FiltersScreenModel(
    this._placeInteractor,
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  Future<int> findCountByFilter(Filter filter) async {
    final found = await _placeInteractor.getAll(
      categories: filter.categories,
      maxRadius: filter.maxRadius,
      minRadius: filter.minRadius,
    );

    return found.length;
  }
}
