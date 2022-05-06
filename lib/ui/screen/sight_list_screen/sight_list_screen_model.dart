import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';

/// Модель экрана "Список мест".
class SightListScreenModel extends ElementaryModel {
  final PlaceInteractor _placeInteractor;
  final SearchInteractor _searchInteractor;
  final SettingsInteractor _settingsInteractor;

  Filter get filter => _searchInteractor.filter;

  set filter(Filter value) {
    _searchInteractor.filter = value;
    _settingsInteractor.saveFilter(value);
  }

  SightListScreenModel(
    ErrorHandler errorHandler,
    this._placeInteractor,
    this._searchInteractor,
    this._settingsInteractor,
  ) : super(errorHandler: errorHandler);

  Future<List<Sight>> getSights() async => _placeInteractor.getAll(
        minRadius: filter.minRadius,
        maxRadius: filter.maxRadius,
        categories: filter.categories,
      );
}
