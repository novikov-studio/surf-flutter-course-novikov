import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/errors.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/store/sight_list_store.dart';
import 'package:places/ui/widget/controls/gradient_fab.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/observable_future_builder.dart';
import 'package:places/ui/widget/controls/search_bar.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/empty_list.dart';

import 'package:places/ui/widget/sliver_sight_list.dart';
import 'package:provider/provider.dart';

/// Экран "Список мест".
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  late final SightListStore _store;

  @override
  void initState() {
    super.initState();
    _store = SightListStore(
      placeInteractor: context.placeInteractor,
      searchInteractor: context.searchInteractor,
    );
    _store.getSights(hidden: false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Provider<SightListStore>.value(
      value: _store,
      child: Scaffold(
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
                  style: theme.appBarTheme.titleTextStyle,
                ),
              ),
            ),

            /// SearchBar
            SliverToBoxAdapter(
              child: _InactiveSearchBar(
                searchBar: const SearchBar(enabled: false),
                onFieldTap: _showSearchDialog,
                onIconTap: _showFilterDialog,
              ),
            ),

            ObservableFutureBuilder<SightList>(
              source: () => _store.getSightsFuture,

              /// Список.
              builder: (_, data) =>
                  SliverSightList(
                    sights: data.toList(growable: false),
                    empty: const EmptyList(
                      icon: AppIcons.list,
                      title: AppStrings.empty,
                    ),
                    mode: CardMode.list,
                  ),

              /// Прогресс.
              loadingBuilder: (_) =>
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(48.0),
                  child: Loader(),
                ),
              ),

              /// Ошибка.
              errorBuilder: (_, error, stacktrace) {
                return SliverFillRemaining(
                  child: EmptyList(
                    icon: AppIcons.error,
                    title: AppStrings.error,
                    details: Errors.humanReadableText(error),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GradientFab(
          label: AppStrings.newSight,
          onPressed: _showAddDialog,
        ),
      ),
    );
  }

  void _showSearchDialog() {
    context.pushScreen(AppRoutes.search, args: _store.filter);
  }

  Future<void> _showFilterDialog() async {
    final result = await context.pushScreen<Filter>(
      AppRoutes.filters,
      args: _store.filter,
    );
    if (result != null) {
      _store.setFilter(result);
     }
  }

  Future<void> _showAddDialog() async {
    final result = await context.pushScreen<bool>(AppRoutes.newSight);
    if (result ?? false) {
      await _store.getSights();
    }
  }
}

/// Виджет для вызова диалогов фильтров и поиска
class _InactiveSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onFieldTap;
  final VoidCallback? onIconTap;
  final SearchBar searchBar;

  @override
  Size get preferredSize => searchBar.preferredSize;

  const _InactiveSearchBar({
    Key? key,
    required this.searchBar,
    this.onFieldTap,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        GestureDetector(
          child: const SearchBar(enabled: false),
          onTap: onFieldTap,
        ),
        Positioned(
          right: 16.0,
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Observer(
                builder: (context) {
                  final store = Provider.of<SightListStore>(context);

                  return SvgIcon(
                    AppIcons.filter,
                    color: store.filterIsEmpty
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.green,
                  );
                },
              ),
              splashRadius: 20.0,
              onPressed: onIconTap,
            ),
          ),
        ),
      ],
    );
  }
}
