import 'package:elementary/elementary.dart';
import 'package:places/data/repository/network_media_repository.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/domain/interactor/place_interactor.dart';
import 'package:places/domain/interactor/search_interactor.dart';
import 'package:places/domain/interactor/settings_interactor.dart';
import 'package:places/domain/repository/favorites_repository.dart';
import 'package:places/domain/repository/filtered_place_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/domain/repository/search_history_repository.dart';
import 'package:places/domain/repository/settings_repository.dart';
import 'package:places/ui/res/logger.dart';

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

  Future<void> init() async {
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

    /// Инициализация репозиториев.
    await settingsRepository.init();

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

    /// Инициализация интеракторов.
    searchInteractor.filter = settingsInteractor.filter;
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
