import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/res/theme_extension.dart';

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
    final theme = Theme.of(context);
    final color = theme.bottomNavigationBarTheme.unselectedItemColor;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.8,
            color: theme.colorScheme.inactiveBlack.withOpacity(0.56 * 0.48),
          ),
        ),
      ),
      position: DecorationPosition.foreground,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          _SvgNavBarItem(
            icon: AppIcons.list,
            activeIcon: AppIcons.listFilled,
            color: color,
          ),
          _SvgNavBarItem(
            icon: AppIcons.map,
            activeIcon: AppIcons.mapFilled,
            color: color,
          ),
          _SvgNavBarItem(
            icon: AppIcons.heart,
            activeIcon: AppIcons.heartFilled,
            color: color,
          ),
          _SvgNavBarItem(
            icon: AppIcons.settings,
            activeIcon: AppIcons.settingsFilled,
            color: color,
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}

class _SvgNavBarItem extends BottomNavigationBarItem {
  _SvgNavBarItem({
    required String icon,
    required String activeIcon,
    Color? color,
    Color? activeColor,
  }) : super(
          icon: SvgPicture.asset(
            icon,
            color: color,
          ),
          activeIcon: SvgPicture.asset(
            activeIcon,
            color: activeColor ?? color,
          ),
          label: '',
        );
}
