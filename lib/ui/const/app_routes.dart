import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/widget/bottom_sheet_wrapper.dart';

/// Имена путей.
abstract class AppRoutes {
  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const details = 'details';
  static const search = 'search';
  static const filters = 'filters';
  static const newSight = 'newSight';
  static const home = 'home';

  static Map<String, WidgetBuilder> routes = {
    /// Сплэш-скрин.
    AppRoutes.splash: (_) => const SplashScreen(),

    /// Туториал.
    AppRoutes.onboarding: (context) =>
        OnboardingScreen(nextScreen: context.routeArgs<String>()),

    /// Главный экран.
    AppRoutes.home: (_) => const HomeScreen(),

    /// Детализация.
    AppRoutes.details: (context) => BottomSheetWrapper(
          builder: (context, scrollController) => SightDetails(
            id: context.routeArgs<String>()!,
            scrollController: scrollController,
          ),
        ),

    /// Фильтры.
    AppRoutes.filters: (context) =>
        FiltersScreen(initialValue: context.routeArgs<Filter>()!),

    /// Поиск.
    AppRoutes.search: (context) =>
        SightSearchScreen(filter: context.routeArgs<Filter>()!),

    /// Новое место.
    AppRoutes.newSight: (_) => const AddSightScreen(),
  };
}
