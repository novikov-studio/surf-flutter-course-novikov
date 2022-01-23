import 'package:flutter/material.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_strings.dart';
import 'package:places/ui/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size(double.infinity, 120.0);

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: const Text(
        AppStrings.appTitle,
        style: largeTitle,
      ),
    );
  }
}
