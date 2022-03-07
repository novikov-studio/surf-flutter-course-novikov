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
import 'package:places/ui/widget/buttons/gradient_fab.dart';
import 'package:places/ui/widget/custom_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/search_bar.dart';
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
      appBar: CustomAppBar(
        title: AppStrings.listTitle.replaceFirst(' ', '\n'),
        height: 180.0,
        bottom: Stack(
          alignment: Alignment.centerRight,
          children: [
            GestureDetector(
              child: const SearchBar(enabled: false),
              onTap: () => context.pushScreen<SightSearchScreen>(
                    (context) => SightSearchScreen(sights: mocks),
              ),
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
                  onPressed: () => context.pushScreen<FiltersScreen>(
                    (context) => FiltersScreen(sights: mocks),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SightList(
        sights: mocks,
        empty: const EmptyList(
          icon: AppIcons.list,
          title: AppStrings.empty,
        ),
        mode: CardMode.list,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientFab(
        label: AppStrings.newSight,
        onPressed: _onFabPressed,
      ),
    );
  }

  void _onFabPressed() {
    context.pushScreen<AddSightScreen>(
      (context) => AddSightScreen(onSightAdd: _onSightAdd),
    );
  }

  void _onSightAdd(Sight sight) {
    setState(() {
      mocks.add(sight);
    });
    Navigator.pop(context);
  }
}
