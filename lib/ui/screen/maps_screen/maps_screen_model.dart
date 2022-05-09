import 'package:elementary/elementary.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/ui/screen/sight_list_screen/mixin/sight_list_model_mixin.dart';

/// Модель экрана "Карта".
class MapsScreenModel extends SightListModel {
  MapsScreenModel(
      ErrorHandler errorHandler,
      PlaceInteractor placeInteractor,
      SearchInteractor searchInteractor,
      SettingsInteractor settingsInteractor,
      ) : super(errorHandler: errorHandler) {
    this.placeInteractor = placeInteractor;
    this.searchInteractor = searchInteractor;
    this.settingsInteractor = settingsInteractor;
  }

  Future<Location?> getCurrentLocation() async =>
      placeInteractor.getCurrentLocation();
}
