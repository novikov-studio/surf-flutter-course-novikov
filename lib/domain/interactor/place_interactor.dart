import 'dart:collection';
import 'dart:io';

import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/repository/favorites_repository.dart';
import 'package:places/domain/repository/filtered_place_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/media_repository.dart';
import 'package:places/domain/repository/place_repository.dart';

/// Интерактор для управления списком интересных мест.
class PlaceInteractor {
  final PlaceRepository _placeRepository;
  final LocationRepository _locationRepository;
  final FavoritesRepository _favoritesRepository;
  final FilteredPlaceRepository _filteredPlaceRepository;
  final MediaRepository _mediaRepository;

  PlaceInteractor({
    required PlaceRepository placeRepository,
    required LocationRepository locationRepository,
    required FavoritesRepository favoritesRepository,
    required FilteredPlaceRepository filteredPlaceRepository,
    required MediaRepository mediaRepository,
  })  : _placeRepository = placeRepository,
        _locationRepository = locationRepository,
        _favoritesRepository = favoritesRepository,
        _filteredPlaceRepository = filteredPlaceRepository,
        _mediaRepository = mediaRepository;

  /// Запрос списка мест.
  Future<List<Sight>> getAll({
    double? maxRadius,
    double? minRadius,
    Set<Category>? categories,
  }) async {
    late Iterable<Place> result;

    if (minRadius == null && maxRadius == null && categories == null) {
      result = await _placeRepository.getAll();
    } else {
      final location =
          maxRadius != null ? await _locationRepository.current() : null;
      final filter = PlaceFilterRequest(
        radius: maxRadius != null
            ? maxRadius * 1000 // км -> м
            : null,
        lng: location?.longitude,
        lat: location?.latitude,
        typeFilter: categories?.map(CategoryMapper.toModel).toSet(),
      );
      result = await _filteredPlaceRepository.getFiltered(filter: filter);
      if (minRadius != null) {
        result = result.where((place) => (place.distance! / 1000) >= minRadius);
      }
    }

    // Если место в Избранном, то берем сразу оттуда, иначе конвертируем Place
    final liked = await getFavorites();
    final favorites = {for (var e in liked) e.id: e};

    return UnmodifiableListView(
      result.map<Sight>((e) => favorites[e.id] ?? SightMapper.fromModel(e)),
    );
  }

  /// Запрос детализации.
  Future<Sight> getOne({required int id}) async {
    final place = await _placeRepository.getOne(id: id);

    try {
      // TODO(novikov): Добавить метод getById в репозиторий
      final favorites = await _favoritesRepository.items();

      return favorites.firstWhere((element) => element.id == id);
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
    final newSight = sight.copyWith(
      isLiked: false,
      plannedDate: null,
      visitedDate: null,
    );
    await _favoritesRepository.remove(newSight);

    return newSight;
  }

  /// Обновление в списке Избранное.
  Future<Sight> schedule({
    required Sight sight,
    required DateTime planned,
  }) async {
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
      sourceId: sourceId,
      insertBeforeId: insertBeforeId,
    );
  }

  /// Запрос списка посещенных.
  Future<List<Sight>> getVisited() async {
    final items = await _favoritesRepository.items();

    return UnmodifiableListView(items.where((sight) => sight.isVisited));
  }

  /// Добавление в список посещенных.
  Future<Sight> addToVisited({required Sight sight}) async {
    final newSight = sight.copyWith(visitedDate: DateTime.now());
    await _favoritesRepository.update(newSight);

    return newSight;
  }

  /// Добавление нового места.
  ///
  /// В поле Sight.urls должны быть пути к файлом.
  Future<Sight> addNew({required Sight sight}) async {
    final paths = sight.urls;

    // Загружаем файлы в память
    final files = {
      for (var path in paths) _basename(path): await File(path).readAsBytes(),
    };

    // Выгружаем файлы на сервер
    final urls = await _mediaRepository.upload(files: files);

    // Заменяем пути к файлам на ссылки
    final newSight = sight.copyWith(urls: urls.values.toList(growable: false));

    // Сохраняем новое место на сервере
    final place =
        await _placeRepository.create(place: SightMapper.toModel(newSight));

    return SightMapper.fromModel(place);
  }

  /// Имя файла по пути (чтобы не подключать библиотеку path).
  static String _basename(String path) {
    final index = path.lastIndexOf('/');

    return index < 0 ? path : path.substring(index + 1);
  }
}
