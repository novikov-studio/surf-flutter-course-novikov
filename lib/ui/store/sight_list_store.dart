import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/sight.dart';

part 'sight_list_store.g.dart';

/// Состояние экрана SightListScreen.
class SightListStore = SightListBase with _$SightListStore;

typedef SightList = Iterable<Sight>;

//ignore: prefer-match-file-name
abstract class SightListBase with Store {
  final PlaceInteractor _placeInteractor;

  ObservableFuture<SightList> get getAllFuture => _getAllFuture;

  late ObservableFuture<SightList> _getAllFuture;

  SightListBase(this._placeInteractor);

  @action
  void getAll({
    double? maxRadius,
    double? minRadius,
    Set<Category>? categories,
  }) {
    final future = _placeInteractor.getAll(
      minRadius: minRadius,
      maxRadius: maxRadius,
      categories: categories,
    );

    _getAllFuture = ObservableFuture(future);
  }
}
