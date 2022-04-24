import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';

part '../../gen/ui/store/sight_list_store.g.dart';

/// Состояние экрана SightListScreen.
class SightListStore = SightListBase with _$SightListStore;

/// Базовое состояние экрана SightListScreen.
//ignore: prefer-match-file-name
abstract class SightListBase with Store {
  final PlaceInteractor _placeInteractor;
  final SearchInteractor _searchInteractor;
  final Observable<bool> _filterIsEmpty = Observable(true);

  /// Отслеживаемый результат зароса списка достопримечательностей.
  ObservableFuture<SightList> get getSightsFuture => _getSightsFuture;

  /// Отслеживаемый признак наличия фильтра.
  bool get filterIsEmpty => _filterIsEmpty.value;

  Filter get filter => _searchInteractor.filter;

  @observable
  ObservableFuture<SightList> _getSightsFuture = ObservableFuture.value([]);

  SightListBase({
    required PlaceInteractor placeInteractor,
    required SearchInteractor searchInteractor,
  })  : _placeInteractor = placeInteractor,
        _searchInteractor = searchInteractor;

  /// Изменение фильтра.
  @action
  void setFilter(Filter value) {
    _searchInteractor.filter = value;
    _filterIsEmpty.value = value.isEmpty;
    getSights();
  }

  /// Запрос списка достопримечательностей.
  @action
  Future<void> getSights({bool hidden = true}) async {
    final future = _placeInteractor.getAll(
      minRadius: filter.minRadius,
      maxRadius: filter.maxRadius,
      categories: filter.categories,
    );

    if (hidden) {
      try {
        final res = await future;
        _getSightsFuture = ObservableFuture.value(res);
      } on Object catch (e) {
        _getSightsFuture = ObservableFuture.error(e);
      }
    } else {
      _getSightsFuture = ObservableFuture(future);
    }
  }
}
