import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_repository.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/controls/gradient_fab.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/search_bar.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/holders/favorites.dart';
import 'package:places/ui/widget/holders/sights.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';

/// Экран "Список мест".
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  SightRepository get sightRepository => Sights.of(context)!;

  late Future<Iterable<Sight>> _reload;
  Filter _filter = const Filter();

  @override
  void initState() {
    super.initState();
    _reload = sightRepository.items(filter: _filter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<Iterable<Sight>>(
      future: _reload,
      builder: (context, snapshot) {
        final isProgress = snapshot.connectionState != ConnectionState.done;
        final hasError = snapshot.hasError;

        /// Список.
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
                    onFieldTap: isProgress ? null : _showSearchDialog,
                    onIconTap: isProgress ? null : _showFilterDialog,
                  ),
                ),

                /// Загрузка.
                if (isProgress)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(48.0),
                      child: Loader(),
                    ),
                  )

                /// Ошибка.
                else if (hasError)
                  const SliverFillRemaining(
                    child: Center(
                      child: EmptyList(
                        icon: AppIcons.error,
                        title: AppStrings.error,
                        details: AppStrings.tryLater,
                      ),
                    ),
                  )

                /// Sight List
                else
                  SliverSightList(
                    sights: snapshot.data!.toList(growable: false),
                    empty: const EmptyList(
                      icon: AppIcons.list,
                      title: AppStrings.empty,
                    ),
                    mode: CardMode.list,
                  ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GradientFab(
            label: AppStrings.newSight,
            onPressed: isProgress ? null : _showAddDialog,
          ),
        );
      },
    );
  }

  void _showSearchDialog() {
    context.pushScreen(AppRoutes.search, args: _filter);
  }

  Future<void> _showFilterDialog() async {
    final result =
        await context.pushScreen<Filter>(AppRoutes.filters, args: _filter);
    if (result != null) {
      setState(() {
        _filter = result;
        _reload = sightRepository.items(filter: _filter);
      });
    }
  }

  Future<void> _showAddDialog() async {
    final result = await context.pushScreen<Sight>(AppRoutes.newSight);
    if (result != null) {
      // TODO(novikov): Обрабатывать возможные ошибки при создании.
      // Вероятно, создавать надо будет на самом экране создания,
      // а сюда просто возвращать результат true
      await sightRepository.create(result);
      setState(() {
        _reload = sightRepository.items(filter: _filter);
      });
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
