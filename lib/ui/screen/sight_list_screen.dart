import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/widget/controls/gradient_fab.dart';
import 'package:places/ui/widget/controls/search_bar.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/favorites.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';

/// Экран "Список мест".
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final List<Sight> sights = mocks;
  late List<Sight> filtered;

  @override
  void initState() {
    super.initState();
    filtered = sights;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnimatedBuilder(
        animation: Favorites.of(context)!,
        builder: (_, __) => CustomScrollView(
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
            /// Sight List
            SliverSightList(
              sights: sights,
              empty: const EmptyList(
                icon: AppIcons.list,
                title: AppStrings.empty,
              ),
              mode: CardMode.list,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientFab(
        label: AppStrings.newSight,
        onPressed: _showAddDialog,
      ),
    );
  }

  void _showSearchDialog() {
    context.pushScreen<SightSearchScreen>(
      (context) => SightSearchScreen(sights: filtered),
    );
  }

  void _showFilterDialog() {
    context.pushScreen<FiltersScreen>(
      (context) => FiltersScreen(sights: sights, onApplyFilter: _onApplyFilter),
    );
  }

  void _showAddDialog() {
    context.pushScreen<AddSightScreen>(
      (context) => AddSightScreen(onSightAdd: _onSightAdd),
    );
  }

  void _onSightAdd(Sight sight) {
    setState(() {
      sights.add(sight);
    });
    Navigator.pop(context);
  }

  void _onApplyFilter(List<Sight> filtered) {
    setState(() {
      this.filtered = filtered;
    });
    Navigator.pop(context);
  }
}

/// Виджет для вызова диалогов фильтров и поиска
class _InactiveSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onFieldTap;
  final VoidCallback onIconTap;
  final SearchBar searchBar;

  @override
  Size get preferredSize => searchBar.preferredSize;

  const _InactiveSearchBar({
    Key? key,
    required this.searchBar,
    required this.onFieldTap,
    required this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              icon: SvgIcon(
                AppIcons.filter,
                color: Theme.of(context).colorScheme.green,
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
