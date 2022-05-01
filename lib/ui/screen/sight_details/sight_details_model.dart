import 'package:elementary/elementary.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/ui/screen/sight_card/mixin/sight_model_mixin.dart';

/// Модель экрана "Детализация".
class SightDetailsModel extends ElementaryModel with SightModelMixin {
  SightDetailsModel(
    ErrorHandler errorHandler,
    PlaceInteractor placeInteractor,
  ) : super(errorHandler: errorHandler) {
    this.placeInteractor = placeInteractor;
  }
}
