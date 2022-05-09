import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';

/// Примесь для моделей экранов "Список мест" и "Карта".
mixin SightListModelMixin {
  late final PlaceInteractor placeInteractor;
  late final SearchInteractor searchInteractor;
  late final SettingsInteractor settingsInteractor;

  Filter get filter => searchInteractor.filter;

  set filter(Filter value) {
    searchInteractor.filter = value;
    settingsInteractor.saveFilter(value);
  }

  Future<List<Sight>> getSights() async => placeInteractor.getAll(
        minRadius: filter.minRadius,
        maxRadius: filter.maxRadius,
        categories: filter.categories,
      );
}

/// Базовый класс модели.
class SightListModel extends ElementaryModel with SightListModelMixin {
  SightListModel({ErrorHandler? errorHandler})
      : super(errorHandler: errorHandler);
}
