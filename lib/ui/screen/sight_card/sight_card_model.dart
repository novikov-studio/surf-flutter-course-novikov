import 'package:elementary/elementary.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/ui/screen/sight_card/mixin/sight_model_mixin.dart';

/// Модель виджета "Карточка места".
class SightCardModel extends ElementaryModel with SightModelMixin {
  SightCardModel(ErrorHandler errorHandler,
      PlaceInteractor placeInteractor,) : super(errorHandler: errorHandler) {
    this.placeInteractor = placeInteractor;
  }
}
