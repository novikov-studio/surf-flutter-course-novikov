import 'dart:async';
import 'dart:collection';

import 'package:places/data/mapper/category_mapper.dart';
import 'package:places/data/mapper/sight_mapper.dart';
import 'package:places/data/model/place_filter_request.dart';
import 'package:places/domain/const/app_settings.dart';
import 'package:places/domain/entity/filter.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/domain/repository/filtered_place_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/search_history_repository.dart';
import 'package:places/domain/repository/settings_repository.dart';
import 'package:places/ui/res/logger.dart';

/// Интерактор для запроса мест с фильтром.
class SearchInteractor {
  final LocationRepository _locationRepository;
  final FilteredPlaceRepository _filteredPlaceRepository;
  final SearchHistoryRepository _searchHistoryRepository;
  final SettingsRepository _settingsRepository;

  Filter get filter => _filter;

  set filter(Filter value) {
    _filter = value;
    _save();
  }

  Filter _filter = const Filter();

  SearchInteractor({
    required LocationRepository locationRepository,
    required FilteredPlaceRepository filteredPlaceRepository,
    required SearchHistoryRepository searchHistoryRepository,
    required SettingsRepository settingsRepository,
  })  : _locationRepository = locationRepository,
        _filteredPlaceRepository = filteredPlaceRepository,
        _searchHistoryRepository = searchHistoryRepository,
        _settingsRepository = settingsRepository {
    _load();
  }

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
  Future<List<String>> getHistory() async => _searchHistoryRepository.items();

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

  /// Сохранение настроек.
  void _save() {
    _settingsRepository.save(key: AppSettings.filter, value: filter.toJson());
  }

  /// Чтение настроек.
  void _load() {
    try {
      final json = _settingsRepository.load<Map<String, dynamic>>(
        key: AppSettings.filter,
      );
      _filter = json != null ? Filter.fromJson(json) : const Filter();
    } on Object catch (e, stacktrace) {
      logError(e, stacktrace);
      _filter = const Filter();
    }
  }
}
