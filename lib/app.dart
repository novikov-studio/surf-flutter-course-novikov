import 'package:flutter/material.dart';
import 'package:places/domain/favorites_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/widget/holders/favorites.dart';

/// Корневой виджет приложения.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Favorites(
      value: FavoritesProvider.createProvider(),
      child: ValueListenableBuilder<bool>(
        valueListenable: Utils.isLight,
        builder: (_, value, __) => MaterialApp(
          title: 'Places',
          theme: value ? Themes.light : Themes.dark,
          initialRoute: AppRoutes.splash,
          routes: {
            /// Сплэш-скрин.
            AppRoutes.splash: (_) => const SplashScreen(),

            /// Туториал.
            AppRoutes.onboarding: (context) =>
                OnboardingScreen(nextScreen: context.routeArgs<String>()),

            /// Главный экран.
            AppRoutes.home: (_) => const HomeScreen(),

            /// Детализация.
            AppRoutes.details: (context) =>
                SightDetails(id: context.routeArgs<String>()!),

            /// Фильтры.
            AppRoutes.filters: (context) =>
                FiltersScreen(sights: context.routeArgs<List<Sight>>()!),

            /// Поиск.
            AppRoutes.search: (context) =>
                SightSearchScreen(sights: context.routeArgs<List<Sight>>()!),

            /// Новое место.
            AppRoutes.newSight: (_) => const AddSightScreen(),
          },
        ),
      ),
    );
  }
}
