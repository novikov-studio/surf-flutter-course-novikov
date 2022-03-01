import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/buttons/gradient_fab.dart';
import 'package:places/ui/widget/custom_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sight_list.dart';

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
