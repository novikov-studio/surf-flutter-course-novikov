import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/domain/favorites_provider.dart';
import 'package:places/domain/location_provider.dart';
import 'package:places/domain/sight_repository.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/widget/holders/favorites.dart';
import 'package:places/ui/widget/holders/locations.dart';
import 'package:places/ui/widget/holders/sights.dart';

/// Корневой виджет приложения.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _locationProvider = LocationProvider.createProvider();

  @override
  Widget build(BuildContext context) {
    return Locations(
      value: _locationProvider,
      child: Favorites(
        value: FavoritesProvider.createProvider(),
        child: Sights(
          value: SightRepository.createRepository(
            locationProvider: _locationProvider,
          ),
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
        ),
      ),
    );
  }
}
