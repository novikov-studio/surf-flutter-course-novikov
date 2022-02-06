import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sight_list.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.favoritesTitle),
          bottom: const _Tabs(
            items: [
              AppStrings.myWishList,
              AppStrings.alreadyVisited,
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SightList(
              sights: mocks.where((sight) => sight.isPlanned),
              empty: const EmptyList(
                icon: AppIcons.card,
                title: AppStrings.empty,
                details: AppStrings.tagPlaces,
              ),
              mode: CardMode.favorites,
            ),
            SightList(
              sights: mocks.where((sight) => sight.isVisited),
              empty: const EmptyList(
                icon: AppIcons.goRouteBig,
                title: AppStrings.empty,
                details: AppStrings.finishRoute,
              ),
              mode: CardMode.favorites,
            ),
          ],
        ),
      ),
    );
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
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          color: Theme.of(context).cardColor,
        ),
        // TODO(novikov): Убрать splash при нажатии
        child: TabBar(
          tabs: items.map((title) => Text(title)).toList(growable: false),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
