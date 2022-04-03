import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/repository_interface/favorites_repository.dart';
import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/data/repository_interface/place_repository.dart';
import 'package:places/domain/sight.dart';

/// Интерактор для управления списком интересных мест.
class PlaceInteractor {
  final PlaceRepository _placeRepository;
  final LocationRepository _locationRepository;
  final FavoritesRepository _favoritesRepository;

  PlaceInteractor({
    required PlaceRepository placeRepository,
    required LocationRepository locationRepository,
    required FavoritesRepository favoritesRepository,
  })  : _placeRepository = placeRepository,
        _locationRepository = locationRepository,
        _favoritesRepository = favoritesRepository;

  /// Запрос списка мест.
  Future<List<Sight>> getAll({
    double? maxRadius,
    double? minRadius,
    Set<String>? categories,
  }) async {
    late Iterable<Place> result;

    if (minRadius == null && maxRadius == null && categories == null) {
      result = await _placeRepository.getAll();
    } else {
      final location =
          maxRadius != null ? await _locationRepository.current() : null;
      final filter = PlaceFilterRequest(
        radius: maxRadius,
        lng: location?.longitude,
        lat: location?.latitude,
        typeFilter: categories?.map(CategoryMapper.toModel).toSet(),
      );
      result = await _placeRepository.getFiltered(filter: filter);
      if (minRadius != null) {
        result = result.where((place) => place.distance! >= maxRadius!);
      }
    }

    // // Фильтруем по радиусу
    // result = result.where(
    //   (place) => LocationRepository.isPointInRingArea(
    //     point: Location(
    //       latitude: place.lat,
    //       longitude: place.lng,
    //     ),
    //     center: location,
    //     maxRadius: radius,
    //   ),
    // );

    return List<Sight>.unmodifiable(result.map<Sight>(SightMapper.fromModel));
  }

  /// Запрос детализации.
  Future<Sight> getOne({required int id}) async {
    final place = await _placeRepository.getOne(id: id);

    return SightMapper.fromModel(place);
  }

  /// Запрос списка Избранное.
  Future<Iterable<Sight>> getFavorites() async {
    return _favoritesRepository.items();
  }

  /// Добавление в Избранное.
  Future<void> addToFavorites({required Sight sight}) async {
    return _favoritesRepository.add(sight);
  }

  /// Удаление из списка Избранное.
  Future<void> removeFromFavorites({required Sight sight}) async {
    return _favoritesRepository.remove(sight);
  }

  /// Запрос списка посещенных.
  Future<List<Sight>> getVisited() async {
    final items = await _favoritesRepository.items();

    return List.unmodifiable(items.where((sight) => sight.isVisited));
  }

  /// Добавление в список посещенных.
  Future<void> addToVisited({required Sight sight}) async {
    return _favoritesRepository.update(sight);
  }

  /// Добавление нового места.
  Future<Sight> addNew({required Sight sight}) async {
    // TODO(novikov): тут, видимо, надо выкладывать локальные файлы на сервер и подставлять ссылки
    final place =
        await _placeRepository.create(place: SightMapper.toModel(sight));

    return SightMapper.fromModel(place);
  }
}
