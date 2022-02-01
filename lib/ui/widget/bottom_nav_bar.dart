import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/const/app_colors.dart';
import 'package:places/ui/const/app_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    Key? key,
    this.currentIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppColors.background,
      currentIndex: currentIndex,
      items: [
        _SvgNavBarItem(
          icon: AppIcons.list,
          activeIcon: AppIcons.listFilled,
        ),
        _SvgNavBarItem(
          icon: AppIcons.map,
          activeIcon: AppIcons.mapFilled,
        ),
        _SvgNavBarItem(
          icon: AppIcons.heart,
          activeIcon: AppIcons.heartFilled,
        ),
        _SvgNavBarItem(
          icon: AppIcons.settings,
          activeIcon: AppIcons.settingsFilled,
        ),
      ],
      onTap: onTap,
    );
  }
}

class _SvgNavBarItem extends BottomNavigationBarItem {
  _SvgNavBarItem({
    required String icon,
    required String activeIcon,
  }) : super(
    icon: SvgPicture.asset(
      icon,
      color: AppColors.secondary,
    ),
    activeIcon: SvgPicture.asset(
      activeIcon,
      color: AppColors.secondary,
    ),
    label: '',
  );
}
