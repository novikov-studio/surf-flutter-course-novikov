import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/custom_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sight_list.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Экран "Список мест".
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.listTitle),
      body: SightList(
        sights: mocks,
        empty: const EmptyList(
          icon: AppIcons.list,
          title: AppStrings.empty,
        ),
        mode: CardMode.list,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_filters',
        onPressed: () {
          context.pushScreen<FiltersScreen>(
            (context) => FiltersScreen(sights: mocks),
          );
        },
        child: const SvgIcon(AppIcons.filter),
      ),
    );
  }
}
