import 'package:places/data/model/place.dart';
import 'package:places/ui/const/app_strings.dart';

/// Вспомогательный класс для преобразования категории в [PlaceType] и наоборот.
// TODO(novikov): Перейти на enum в Sight.
abstract class CategoryMapper {
  static String fromModel(PlaceType model) {
    switch (model) {
      case PlaceType.hotel:
        return AppStrings.hotel;
      case PlaceType.cafe:
        return AppStrings.cafe;
      case PlaceType.restaurant:
        return AppStrings.restaurant;
      case PlaceType.park:
        return AppStrings.park;
      case PlaceType.museum:
        return AppStrings.museum;
      case PlaceType.other:
        return AppStrings.particularPlace;
      // Неизвестные
      case PlaceType.theatre:
        return AppStrings.particularPlace;
      case PlaceType.temple:
        return AppStrings.particularPlace;
      case PlaceType.monument:
        return AppStrings.particularPlace;

      default:
        return AppStrings.particularPlace;
    }
  }

  static PlaceType toModel(String category) {
    switch (category) {
      case AppStrings.hotel:
        return PlaceType.hotel;
      case AppStrings.cafe:
        return PlaceType.cafe;
      case AppStrings.restaurant:
        return PlaceType.restaurant;
      case AppStrings.park:
        return PlaceType.park;
      case AppStrings.museum:
        return PlaceType.museum;
      case AppStrings.particularPlace:
        return PlaceType.other;

      default:
        return PlaceType.other;
    }
  }
}
