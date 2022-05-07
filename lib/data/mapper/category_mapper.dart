import 'package:places/data/model/place.dart';
import 'package:places/domain/entity/sight.dart';

/// Вспомогательный класс для преобразования категории в [PlaceType] и наоборот.
abstract class CategoryMapper {
  static Category fromModel(PlaceType model) {
    switch (model) {
      case PlaceType.hotel:
        return Category.hotel;
      case PlaceType.cafe:
        return Category.cafe;
      case PlaceType.restaurant:
        return Category.restaurant;
      case PlaceType.park:
        return Category.park;
      case PlaceType.museum:
        return Category.museum;
      case PlaceType.other:
        return Category.particularPlace;
      // Неизвестные
      case PlaceType.theatre:
        return Category.particularPlace;
      case PlaceType.temple:
        return Category.particularPlace;
      case PlaceType.monument:
        return Category.particularPlace;

      default:
        return Category.particularPlace;
    }
  }

  static PlaceType toModel(Category category) {
    switch (category) {
      case Category.hotel:
        return PlaceType.hotel;
      case Category.cafe:
        return PlaceType.cafe;
      case Category.restaurant:
        return PlaceType.restaurant;
      case Category.park:
        return PlaceType.park;
      case Category.museum:
        return PlaceType.museum;
      case Category.particularPlace:
        return PlaceType.other;

      default:
        return PlaceType.other;
    }
  }

  static String toStr(Category category) => category.name;

  static Category fromStr(String value) => Category.values.firstWhere(
        (element) => element.name == value,
        orElse: () => Category.particularPlace,
      );
}
