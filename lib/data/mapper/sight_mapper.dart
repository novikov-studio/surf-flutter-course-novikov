import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';

/// Вспомогательный класс для преобразования [Sight] в [Place] и наоборот.
abstract class SightMapper {
  static Sight fromModel(Place model) => Sight(
    id: model.id!,
    name: model.name,
    location: Location(
      latitude: model.lat,
      longitude: model.lng,
    ),
    type: CategoryMapper.fromModel(model.placeType),
    urls: model.urls,
    details: model.description,
  );

  static Place toModel(Sight sight) => Place(
    // id: null, // API не предполагает передачу id на запись
    name: sight.name,
    lat: sight.location.latitude,
    lng: sight.location.longitude,
    placeType: CategoryMapper.toModel(sight.type),
    urls: sight.urls,
    description: sight.details ?? '',
  );
}
