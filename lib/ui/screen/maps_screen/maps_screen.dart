import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/maps_screen/maps_screen_wm.dart';
import 'package:places/ui/screen/maps_screen/widget/map_fab.dart';
import 'package:places/ui/screen/maps_screen/widget/map_view.dart';
import 'package:places/ui/widget/gradient_fab.dart';
import 'package:places/ui/widget/inactive_search_bar.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/simple_app_bar.dart';

/// Экран "Карта".
class MapsScreen extends ElementaryWidget<IMapsScreenWidgetModel> {
  const MapsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultMapsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMapsScreenWidgetModel wm) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: AppStrings.mapTitle,
        bottom: InactiveSearchBar(
          filterState: wm.filterIsEmpty,
          searchBar: const SearchBar(enabled: false),
          onFieldTap: wm.showSearchDialog,
          onIconTap: wm.showFilterDialog,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// Карта.
          MapView(wm: wm),

          /// Обновление списка мест на карте.
          Positioned(
            left: 16.0,
            bottom: 36.0,
            child: MapFab(
              heroTag: 'fab_refresh',
              icon: AppIcons.refresh,
              listenable: wm.sightsState,
              onPressed: () => wm.loadSights(hidden: false),
            ),
          ),

          /// Новое место.
          Positioned(
            bottom: 36.0,
            child: GradientFab(
              label: AppStrings.newSight,
              elevation: 8.0,
              onPressed: wm.showAddDialog,
            ),
          ),

          /// Определение местоположения.
          Positioned(
            right: 16.0,
            bottom: 36.0,
            child: MapFab(
              heroTag: 'fab_location',
              icon: AppIcons.geolocation,
              listenable: wm.searchLocationState,
              onPressed: wm.showCurrentLocation,
            ),
          ),
        ],
      ),
    );
  }
}
