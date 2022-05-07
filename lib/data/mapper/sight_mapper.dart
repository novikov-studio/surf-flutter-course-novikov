import 'package:places/data/database/database.dart';
import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/entity/sight.dart';

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

  static Favorite toDbModel(Sight sight) => Favorite(
        id: sight.id,
        name: sight.name,
        urls: sight.urls.join('|'),
        info: sight.info,
        details: sight.details,
        latitude: sight.location.latitude,
        longitude: sight.location.longitude,
        category: CategoryMapper.toStr(sight.type),
        plannedDate: sight.plannedDate,
        visitedDate: sight.visitedDate,
      );

  static Sight fromDbModel(Favorite favorite) => Sight(
        id: favorite.id,
        name: favorite.name,
        urls: favorite.urls.split('|'),
        info: favorite.info,
        details: favorite.details,
        location: Location(
          latitude: favorite.latitude,
          longitude: favorite.longitude,
        ),
        type: CategoryMapper.fromStr(favorite.category),
        plannedDate: favorite.plannedDate,
        visitedDate: favorite.visitedDate,
        isLiked: true,
      );
}
