import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/const/app_colors.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/custom_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/sight_list.dart';

/// Экран "Список мест"
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
      backgroundColor: AppColors.background,
      body: SightList(
        sights: mocks,
        empty: const EmptyList(
          icon: AppIcons.list,
          title: AppStrings.empty,
        ),
        mode: CardMode.list,
      ),
    );
  }
}
