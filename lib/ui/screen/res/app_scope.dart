import 'package:elementary/elementary.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/network_media_repository.dart';
import 'package:places/data/repository_interface/favorites_repository.dart';
import 'package:places/data/repository_interface/filtered_place_repository.dart';
import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/data/repository_interface/place_repository.dart';
import 'package:places/data/repository_interface/search_history_repository.dart';
import 'package:places/data/repository_interface/settings_repository.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/ui/screen/res/logger.dart';

/// Зависимости приложения.
class AppScope implements IAppScope {
  static const baseUrl = 'https://test-backend-flutter.surfstudio.ru';

  late final RestClient _restClient;

  late final PlaceInteractor _placeInteractor;
  late final SearchInteractor _searchInteractor;
  late final SettingsInteractor _settingsInteractor;

  late final ErrorHandler _errorHandler;

  @override
  PlaceInteractor get placeInteractor => _placeInteractor;

  @override
  SearchInteractor get searchInteractor => _searchInteractor;

  @override
  SettingsInteractor get settingsInteractor => _settingsInteractor;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  AppScope() {
    _restClient = RestClient.getInstance(baseUrl: baseUrl);
    _errorHandler = const AppErrorHandler();

    /// Репозитории.
    final placeRepository = PlaceRepository.network(restClient: _restClient);
    final filteredPlaceRepository =
        FilteredPlaceRepository.network(restClient: _restClient);
    final networkMediaRepository = NetworkMediaRepository(
      restClient: _restClient,
    );
    final searchHistoryRepository = SearchHistoryRepository.getInstance();
    final favoritesRepository = FavoritesRepository.getInstance();
    final settingsRepository = SettingsRepository.getInstance();
    const locationRepository = LocationRepository.getInstance();

    /// Интеракторы.
    _placeInteractor = PlaceInteractor(
      placeRepository: placeRepository,
      locationRepository: locationRepository,
      favoritesRepository: favoritesRepository,
      filteredPlaceRepository: filteredPlaceRepository,
      mediaRepository: networkMediaRepository,
    );

    _searchInteractor = SearchInteractor(
      locationRepository: locationRepository,
      filteredPlaceRepository: filteredPlaceRepository,
      searchHistoryRepository: searchHistoryRepository,
    );

    _settingsInteractor =
        SettingsInteractor(settingsRepository: settingsRepository);
  }
}

/// Интерфейс зависимостей приложения.
abstract class IAppScope {
  PlaceInteractor get placeInteractor;

  SearchInteractor get searchInteractor;

  SettingsInteractor get settingsInteractor;

  ErrorHandler get errorHandler;
}

/// Глобальный обработчик ошибок (для Elementary).
class AppErrorHandler implements ErrorHandler {
  const AppErrorHandler();

  @override
  void handleError(Object error) {
    logError(error);
  }
}
