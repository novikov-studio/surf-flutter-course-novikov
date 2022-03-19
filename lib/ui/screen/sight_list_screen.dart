import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
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
              sights: filtered,
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
    context.pushScreen(AppRoutes.search, args: filtered);
  }

  Future<void> _showFilterDialog() async {
    final result =
        await context.pushScreen<List<Sight>>(AppRoutes.filters, args: sights);
    if (result != null) {
      setState(() {
        filtered = result;
      });
    }
  }

  Future<void> _showAddDialog() async {
    final result = await context.pushScreen<Sight>(AppRoutes.newSight);
    if (result != null) {
      setState(() {
        sights.add(result);
      });
    }
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
