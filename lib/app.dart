import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/redux/middleware/search_middleware.dart';
import 'package:places/ui/redux/reducer/reducer.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

/// Корневой виджет приложения.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  final _locationRepository = const LocationRepository.getInstance();
  final _restClient = RestClient.getInstance(baseUrl: baseUrl);
  late final FilteredPlaceRepository _filteredPlaceRepository;
  late final Store<AppState> _reduxStore;
  late final SearchInteractor _searchInteractor;

  @override
  void initState() {
    super.initState();
    _filteredPlaceRepository =
        FilteredPlaceRepository.network(restClient: _restClient);

    _searchInteractor = _searchInteractorBuilder();
    _reduxStore = _reduxStoreBuilder(_searchInteractor);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaceInteractor>(create: _placeInteractorBuilder),
        Provider<SearchInteractor>.value(value: _searchInteractor),
        ChangeNotifierProvider<SettingsInteractor>(
          create: _settingsInteractorBuilder,
        ),
        Provider<IAppScope>(
          create: (context) => AppScope(
            placeInteractor: context.placeInteractor,
            settingsInteractor: context.read<SettingsInteractor>(),
            errorHandler: const AppErrorHandler(),
          ),
        ),
      ],
      child: StoreProvider<AppState>(
        store: _reduxStore,
        child: const _MaterialApp(),
      ),
    );
  }

  PlaceInteractor _placeInteractorBuilder(BuildContext _) => PlaceInteractor(
        placeRepository: PlaceRepository.network(restClient: _restClient),
        locationRepository: _locationRepository,
        favoritesRepository: FavoritesRepository.getInstance(),
        filteredPlaceRepository: _filteredPlaceRepository,
        mediaRepository: NetworkMediaRepository(restClient: _restClient),
      );

  SearchInteractor _searchInteractorBuilder() => SearchInteractor(
        locationRepository: _locationRepository,
        filteredPlaceRepository: _filteredPlaceRepository,
        searchHistoryRepository: SearchHistoryRepository.getInstance(),
      );

  SettingsInteractor _settingsInteractorBuilder(BuildContext _) =>
      SettingsInteractor(
        settingsRepository: SettingsRepository.getInstance(),
      );

  Store<AppState> _reduxStoreBuilder(SearchInteractor searchInteractor) =>
      Store<AppState>(
        reducer,
        initialState: const AppState(),
        middleware: [
          SearchMiddleware(searchInteractor: searchInteractor),
        ],
      );
}

/// Material App.
class _MaterialApp extends StatelessWidget {
  const _MaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsInteractor, bool>(
      selector: (_, selectInteractor) => selectInteractor.isLightTheme,
      builder: (_, isLight, __) => MaterialApp(
        title: AppStrings.appTitle,
        theme: isLight ? Themes.light : Themes.dark,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        locale: const Locale('ru'),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        builder: (_, child) => Responsive(child: child!),
      ),
    );
  }
}
