import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';

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
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.8,
            color: Theme.of(context)
                .colorScheme
                .inactiveBlack
                .withOpacity(0.56 * 0.48),
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
      ),
    );
  }
}

class _SvgNavBarItem extends BottomNavigationBarItem {
  _SvgNavBarItem({
    required String icon,
    required String activeIcon,
  }) : super(
          icon: SvgIcon(icon),
          activeIcon: SvgIcon(activeIcon),
          label: '',
        );
}
