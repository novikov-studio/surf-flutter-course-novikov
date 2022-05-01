import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';

/// Модель экрана "Список мест".
class SightListScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;
  final SearchInteractor _searchInteractor;

  Filter get filter => _searchInteractor.filter;

  set filter(Filter value) {
    _searchInteractor.filter = value;
  }

  SightListScreenModel(
    ErrorHandler errorHandler,
    this._placeInteractor,
    this._searchInteractor,
  ) : super(errorHandler: errorHandler);

  Future<List<Sight>> getSights() async => _placeInteractor.getAll(
        minRadius: filter.minRadius,
        maxRadius: filter.maxRadius,
        categories: filter.categories,
      );
}
