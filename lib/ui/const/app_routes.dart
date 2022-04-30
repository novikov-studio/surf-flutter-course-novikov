import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/adaptive_filters_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/list_picker.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details/sight_details.dart';
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
  static const categories = 'categories';
  static const home = 'home';

  static Map<String, WidgetBuilder> routes = {
    /// Сплэш-скрин.
    AppRoutes.splash: (_) => const SplashScreen(),

    /// Туториал.
    AppRoutes.onboarding: (_) => const OnboardingScreen(),

    /// Главный экран.
    AppRoutes.home: (_) => const HomeScreen(),

    /// Детализация.
    AppRoutes.details: (context) => BottomSheetWrapper(
          builder: (context, scrollController) => SightDetails(
            scrollController: scrollController,
          ),
        ),

    /// Фильтры.
    AppRoutes.filters: (_) => const AdaptiveFiltersScreen(),

    /// Поиск.
    AppRoutes.search: (_) => const SightSearchScreen(),

    /// Новое место.
    AppRoutes.newSight: (_) => const AddSightScreen(),

    /// Выбор категории.
    AppRoutes.categories: (context) => ListPicker<Category>(
          title: AppStrings.categoryTitle,
          items: Category.values,
          names: Categories.titles,
          initialValue: context.routeArgs<Category>(),
        ),
  };
}
