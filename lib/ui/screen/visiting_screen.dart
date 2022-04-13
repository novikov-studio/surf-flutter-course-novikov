import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sliver_sight_list.dart';
import 'package:provider/provider.dart';

/// Экран "Избранное".
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  late Future<Iterable<Sight>> _reloadProc;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: SimpleAppBar(
          title: AppStrings.favoritesTitle,
          bottom: const _Tabs(
            items: [
              AppStrings.myWishList,
              AppStrings.alreadyVisited,
            ],
          ),
        ),
        body: ChangeNotifierProvider<FavoritesNotifier>(
          create: (_) => FavoritesNotifier(_reload),
          child: Builder(
            builder: (context) {
              context.watch<FavoritesNotifier>();

              return FutureBuilder<Iterable<Sight>>(
                future: _reloadProc,
                builder: (context, snapshot) {
                  // Прогресс
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Loader();
                  }
                  final data = snapshot.data!;

                  return TabBarView(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverSightList(
                            sights: data
                                .where((sight) => !sight.isVisited)
                                .toList(growable: false),
                            empty: const EmptyList(
                              icon: AppIcons.card,
                              title: AppStrings.empty,
                              details: AppStrings.tagPlaces,
                            ),
                            mode: CardMode.favorites,
                            onOrderChanged: (sourceId, insertAfterId) =>
                                _onDragComplete(
                              context,
                              sourceId,
                              insertAfterId,
                            ),
                          ),
                        ],
                      ),
                      CustomScrollView(
                        slivers: [
                          SliverSightList(
                            sights: data
                                .where((sight) => sight.isVisited)
                                .toList(growable: false),
                            empty: const EmptyList(
                              icon: AppIcons.goRouteBig,
                              title: AppStrings.empty,
                              details: AppStrings.finishRoute,
                            ),
                            mode: CardMode.favorites,
                            onOrderChanged: (sourceId, insertAfterId) =>
                                _onDragComplete(
                              context,
                              sourceId,
                              insertAfterId,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onDragComplete(
    BuildContext context,
    int sourceId,
    int? insertAfterId,
  ) async {
    final favoritesNotifier = FavoritesNotifier.of(context)!;

    await context.placeInteractor.reorderInFavorites(
      sourceId: sourceId,
      insertBeforeId: insertAfterId,
    );

    favoritesNotifier.trigger();
  }

  void _reload() {
    _reloadProc = context.placeInteractor.getFavorites();
  }
}

class _Tabs extends StatelessWidget implements PreferredSizeWidget {
  final List<String> items;

  @override
  Size get preferredSize => const Size(double.infinity, 52.0);

  const _Tabs({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        clipBehavior: Clip.antiAlias,
        // TODO(novikov): Добавить splash c закруглением при нажатии
        // Судя по исходникам TabBar, каждый таб оборачивается в InkWell,
        // поэтому штатными средствами можно только убрать splash.
        // Ждем-с: https://github.com/flutter/flutter/issues/50341
        child: Container(
          height: 40.0,
          color: Theme.of(context).cardColor,
          child: TabBar(
            tabs: items.map(Text.new).toList(growable: false),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

class FavoritesNotifier extends ValueNotifier<bool> {
  final VoidCallback _callback;

  FavoritesNotifier(this._callback) : super(true);

  static FavoritesNotifier? of(BuildContext context) =>
      context.read<FavoritesNotifier>();

  void trigger() {
    _callback();
    value = !value;
  }
}
