import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/network_media_repository.dart';
import 'package:places/data/repository_interface/favorites_repository.dart';
import 'package:places/data/repository_interface/filtered_place_repository.dart';
import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/data/repository_interface/place_repository.dart';
import 'package:places/data/repository_interface/search_history_repository.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    _filteredPlaceRepository =
        FilteredPlaceRepository.network(restClient: _restClient);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaceInteractor>(
          create: (_) => PlaceInteractor(
            placeRepository: PlaceRepository.network(restClient: _restClient),
            locationRepository: _locationRepository,
            favoritesRepository: FavoritesRepository.getInstance(),
            filteredPlaceRepository: _filteredPlaceRepository,
            mediaRepository: NetworkMediaRepository(restClient: _restClient),
          ),
        ),
        Provider<SearchInteractor>(
          create: (_) => SearchInteractor(
            locationRepository: _locationRepository,
            filteredPlaceRepository: _filteredPlaceRepository,
            searchHistoryRepository: SearchHistoryRepository.getInstance(),
          ),
        ),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: Utils.isLight,
        builder: (_, value, __) => MaterialApp(
          title: AppStrings.appTitle,
          theme: value ? Themes.light : Themes.dark,
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
      ),
    );
  }
}
