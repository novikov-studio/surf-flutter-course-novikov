import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/data/repository_interface/favorites_repository.dart';
import 'package:places/data/repository_interface/filtered_place_repository.dart';
import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/data/repository_interface/place_repository.dart';
import 'package:places/domain/sight.dart';

/// Интерактор для управления списком интересных мест.
class PlaceInteractor {
  final PlaceRepository _placeRepository;
  final LocationRepository _locationRepository;
  final FavoritesRepository _favoritesRepository;
  final FilteredPlaceRepository _filteredPlaceRepository;

  PlaceInteractor({
    required PlaceRepository placeRepository,
    required LocationRepository locationRepository,
    required FavoritesRepository favoritesRepository,
    required FilteredPlaceRepository filteredPlaceRepository,
  })  : _placeRepository = placeRepository,
        _locationRepository = locationRepository,
        _favoritesRepository = favoritesRepository,
        _filteredPlaceRepository = filteredPlaceRepository;

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
      result = await _filteredPlaceRepository.getFiltered(filter: filter);
      if (minRadius != null) {
        result = result.where((place) => place.distance! >= maxRadius!);
      }
    }

    // Если место в Избранном, то берем сразу оттуда, иначе конвертируем Place
    final liked = await getFavorites();
    final favorites = {for (var e in liked) int.parse(e.id): e};

    return List<Sight>.unmodifiable(
      result.map<Sight>((e) => favorites[e.id] ?? SightMapper.fromModel(e)),
    );
  }

  /// Запрос детализации.
  Future<Sight> getOne({required int id}) async {
    final place = await _placeRepository.getOne(id: id);

    try {
      // TODO(novikov): Добавить метод getById в репозиторий
      final favorites = await _favoritesRepository.items();
      final sId = '$id';

      return favorites.firstWhere((element) => element.id == sId);
    } on Object {
      return SightMapper.fromModel(place);
    }
  }

  /// Запрос списка Избранное.
  Future<Iterable<Sight>> getFavorites() async {
    return _favoritesRepository.items();
  }

  /// Добавление в Избранное.
  Future<Sight> addToFavorites({required Sight sight}) async {
    final newSight = sight.copyWith(isLiked: true);
    await _favoritesRepository.add(newSight);

    return newSight;
  }

  /// Удаление из списка Избранное.
  Future<Sight> removeFromFavorites({required Sight sight}) async {
    final newSight = sight.copyWith(isLiked: false);
    await _favoritesRepository.remove(newSight);

    return newSight;
  }

  /// Обновление в списке Избранное.
  Future<Sight> schedule({required Sight sight, required DateTime planned,}) async {
    final newSight = sight.copyWith(plannedDate: planned);
    await _favoritesRepository.update(newSight);

    return newSight;
  }

  /// Сортировка в списке Избранное.
  Future<void> reorderInFavorites({
    required int sourceId,
    int? insertBeforeId,
  }) async {
    return _favoritesRepository.reorder(
      sourceId: '$sourceId',
      insertBeforeId: '$insertBeforeId',
    );
  }

  /// Запрос списка посещенных.
  Future<List<Sight>> getVisited() async {
    final items = await _favoritesRepository.items();

    return List.unmodifiable(items.where((sight) => sight.isVisited));
  }

  /// Добавление в список посещенных.
  Future<Sight> addToVisited({required Sight sight}) async {
    final newSight = sight.copyWith(visitedDate: DateTime.now());
    await _favoritesRepository.update(newSight);

    return newSight;
  }

  /// Добавление нового места.
  Future<Sight> addNew({required Sight sight}) async {
    // TODO(novikov): тут, видимо, надо выкладывать локальные файлы на сервер и подставлять ссылки
    final place =
        await _placeRepository.create(place: SightMapper.toModel(sight));

    return SightMapper.fromModel(place);
  }
}
