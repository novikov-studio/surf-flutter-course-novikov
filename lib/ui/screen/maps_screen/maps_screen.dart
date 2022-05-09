import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/maps_screen/maps_screen_wm.dart';
import 'package:places/ui/screen/maps_screen/widget/map_fab.dart';
import 'package:places/ui/screen/maps_screen/widget/map_view.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
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

          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 36.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MapFab(
                      heroTag: 'fab_refresh',
                      icon: AppIcons.refresh,
                      listenable: wm.sightsState,
                      onPressed: () => wm.loadSights(hidden: false),
                    ),
                    StateNotifierBuilder<Sight>(
                      listenableState: wm.selectedSight,
                      builder: (_, sight) {
                        return sight == null
                            ? GradientFab(
                                label: AppStrings.newSight,
                                elevation: 8.0,
                                onPressed: wm.showAddDialog,
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    MapFab(
                      heroTag: 'fab_location',
                      icon: AppIcons.geolocation,
                      listenable: wm.searchLocationState,
                      onPressed: wm.showCurrentLocation,
                    ),
                  ],
                ),
                StateNotifierBuilder<Sight>(
                  listenableState: wm.selectedSight,
                  builder: (_, sight) {
                    return sight != null
                        ? Dismissible(
                            key: ValueKey('map_card_${sight.id}'),
                            onDismissed: (_) {
                              wm.selectSight(null);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SightCard(
                                sight: sight,
                                mode: CardMode.map,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
