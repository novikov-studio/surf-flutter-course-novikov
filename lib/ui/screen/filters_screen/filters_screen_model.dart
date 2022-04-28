import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/filter.dart';

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
