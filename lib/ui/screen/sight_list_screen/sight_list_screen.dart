import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_list_screen/sight_list_screen_wm.dart';
import 'package:places/ui/widget/elementary/state_notifier_builder_ex.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/gradient_fab.dart';
import 'package:places/ui/widget/inactive_search_bar.dart';
import 'package:places/ui/widget/loader.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';

/// Экран "Список мест".
class SightListScreen extends ElementaryWidget<ISightListScreenWidgetModel> {
  const SightListScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSightListScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISightListScreenWidgetModel wm) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// AppBar
          SliverAppBar(
            expandedHeight: 140.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.78,
              collapseMode: CollapseMode.pin,
              titlePadding: const EdgeInsets.all(16.0),
              centerTitle: true,
              title: Text(
                AppStrings.listTitle,
                style: wm.theme.appBarTheme.titleTextStyle,
              ),
            ),
          ),

          /// SearchBar
          SliverToBoxAdapter(
            child: InactiveSearchBar(
              filterState: wm.filterIsEmpty,
              searchBar: const SearchBar(enabled: false),
              onFieldTap: wm.showSearchDialog,
              onIconTap: wm.showFilterDialog,
            ),
          ),

          EntityStateNotifierBuilderEx<List<Sight>>(
            listenableEntityState: wm.sightsState,

            /// Инициализация = Прогресс.
            initialBuilder: (_) => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: Loader(),
              ),
            ),

            /// Список.
            builder: (_, data) => SliverSightList(
              sights: data!,
              empty: const EmptyList(
                icon: AppIcons.list,
                title: AppStrings.empty,
              ),
              mode: CardMode.list,
            ),

            /// Прогресс.
            loadingBuilder: (_, __) => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: Loader(),
              ),
            ),

            /// Ошибка.
            errorBuilder: (_, error, __) {
              return SliverFillRemaining(
                child: EmptyList(
                  icon: AppIcons.error,
                  title: AppStrings.error,
                  details: error?.humanReadableText ?? AppStrings.unknownError,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientFab(
        label: AppStrings.newSight,
        onPressed: wm.showAddDialog,
      ),
    );
  }
}
