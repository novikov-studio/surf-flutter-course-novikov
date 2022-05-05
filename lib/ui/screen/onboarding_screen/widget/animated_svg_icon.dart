import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen_wm.dart';
import 'package:provider/provider.dart';

/// Анимированная иконка.
class AnimatedSvgIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color color;
  final int index;

  const AnimatedSvgIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wm = context.read<IOnboardingScreenWidgetModel>();

    return StateNotifierBuilder<IconAnimationMode>(
      listenableState: wm.iconAnimationMode,
      builder: (_, __) {
        return AnimatedBuilder(
          animation: wm.iconSizeInterpolator,
          builder: (context, child) {
            return Transform.scale(
              scale: wm.iconSizeInterpolate(index),
              alignment: Alignment.bottomCenter,
              child: child,
            );
          },
          child: SvgPicture.asset(
            icon,
            width: size,
            height: size,
            color: color,
          ),
        );
      },
    );
  }
}
