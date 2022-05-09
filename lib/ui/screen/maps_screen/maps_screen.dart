import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/maps_screen/maps_screen_wm.dart';
import 'package:places/ui/screen/maps_screen/widget/map_fab.dart';
import 'package:places/ui/screen/maps_screen/widget/map_view.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/widget/elementary/state_notifier_builder_ex.dart';
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
                    /// Кнопка "Обновить".
                    MapFab(
                      heroTag: 'fab_refresh',
                      icon: AppIcons.refresh,
                      listenable: wm.sightsState,
                      onPressed: () => wm.loadSights(hidden: false),
                    ),

                    /// Кнопка "Новое место".
                    StateNotifierBuilder<Sight>(
                      listenableState: wm.selectedSight,
                      builder: (_, sight) {
                        final visible = sight == null;

                        return AnimatedOpacity(
                          opacity: visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: GradientFab(
                            label: AppStrings.newSight,
                            elevation: 8.0,
                            onPressed: visible ? wm.showAddDialog : null,
                          ),
                        );
                      },
                    ),

                    /// Кнопка "Геолокация".
                    MapFab(
                      heroTag: 'fab_location',
                      icon: AppIcons.geolocation,
                      listenable: wm.searchLocationState,
                      onPressed: wm.showCurrentLocation,
                    ),
                  ],
                ),

                /// Карточка выбранного места.
                StateNotifierBuilderEx<Sight>(
                  listenableState: wm.selectedSight,
                  builder: (_, prev, sight, __) {
                    final source = sight ?? prev;
                    final sightCard = source != null
                        ? Dismissible(
                            key: ValueKey('map_card_${source.id}'),
                            onDismissed: (_) {
                              wm.selectSight(null);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SightCard(
                                sight: source,
                                mode: CardMode.map,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();

                    return AnimatedCrossFade(
                      crossFadeState: sight != null
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.bottomCenter,
                      firstChild: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: sightCard,
                      ),
                      secondChild: const SizedBox.shrink(),
                    );
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
