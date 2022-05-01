import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/visiting_screen/visiting_screen_wm.dart';
import 'package:places/ui/screen/visiting_screen/widgets/rounded_tabs.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';
import 'package:provider/provider.dart';

/// Экран "Избранное".
class VisitingScreen extends ElementaryWidget<IVisitingScreenWidgetModel> {
  const VisitingScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultVisitingScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IVisitingScreenWidgetModel wm) {
    return Provider<IVisitingScreenWidgetModel>.value(
      value: wm,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: SimpleAppBar(
            title: AppStrings.favoritesTitle,
            bottom: const RoundedTabs(
              items: [
                AppStrings.myWishList,
                AppStrings.alreadyVisited,
              ],
            ),
          ),
          body: EntityStateNotifierBuilder<Iterable<Sight>>(
            listenableEntityState: wm.sightState,

            /// Загрузка списка.
            loadingBuilder: (_, __) => const Loader(),

            /// Ошибка загрузки.
            errorBuilder: (_, error, __) => EmptyList(
              icon: AppIcons.error,
              title: AppStrings.error,
              details: error?.humanReadableText ?? AppStrings.unknownError,
            ),

            /// Данные.
            builder: (context, sights) {
              return TabBarView(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverSightList(
                        sights: sights!
                            .where((sight) => !sight.isVisited)
                            .toList(growable: false),
                        empty: const EmptyList(
                          icon: AppIcons.card,
                          title: AppStrings.empty,
                          details: AppStrings.tagPlaces,
                        ),
                        mode: CardMode.favorites,
                        onOrderChanged: wm.reorder,
                      ),
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverSightList(
                        sights: sights
                            .where((sight) => sight.isVisited)
                            .toList(growable: false),
                        empty: const EmptyList(
                          icon: AppIcons.goRouteBig,
                          title: AppStrings.empty,
                          details: AppStrings.finishRoute,
                        ),
                        mode: CardMode.favorites,
                        onOrderChanged: wm.reorder,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
