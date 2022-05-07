import 'dart:async';
import 'dart:collection';

import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/repository/filtered_place_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/search_history_repository.dart';

/// Интерактор для запроса мест с фильтром.
class SearchInteractor {
  static const _historyViewSize = 20;

  final LocationRepository _locationRepository;
  final FilteredPlaceRepository _filteredPlaceRepository;
  final SearchHistoryRepository _searchHistoryRepository;

  Filter filter = const Filter();

  SearchInteractor({
    required LocationRepository locationRepository,
    required FilteredPlaceRepository filteredPlaceRepository,
    required SearchHistoryRepository searchHistoryRepository,
  })  : _locationRepository = locationRepository,
        _filteredPlaceRepository = filteredPlaceRepository,
        _searchHistoryRepository = searchHistoryRepository;

  /// Запрос списка мест, удовлетворяющих фильтру.
  Future<List<Sight>> searchPlaces({required String name}) async {
    await addToHistory(name);

    final request = await _buildRequest(pattern: name);

    final places = await _filteredPlaceRepository.getFiltered(
      filter: request,
    );

    return UnmodifiableListView(places.map(SightMapper.fromModel));
  }

  /// Возвращает историю поисковых запросов.
  Future<List<String>> getHistory() async =>
      _searchHistoryRepository.items(lastCount: _historyViewSize);

  /// Добавление в историю.
  Future<void> addToHistory(String value) async =>
      _searchHistoryRepository.add(value);

  /// Удаление из истории.
  Future<void> removeFromHistory(String value) async =>
      _searchHistoryRepository.remove(value);

  /// Очистка истории.
  Future<void> clearHistory() async => _searchHistoryRepository.clear();

  /// Формирование запроса.
  Future<PlaceFilterRequest> _buildRequest({String? pattern}) async {
    final location =
        filter.maxRadius != null ? await _locationRepository.current() : null;

    return PlaceFilterRequest(
      radius: filter.maxRadius != null
          ? filter.maxRadius! * 1000.0 // км -> м,
          : null,
      typeFilter: filter.categories?.map(CategoryMapper.toModel).toSet(),
      nameFilter: pattern,
      lat: location?.latitude,
      lng: location?.longitude,
    );
  }
}
