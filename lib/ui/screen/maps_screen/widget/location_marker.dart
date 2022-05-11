import 'package:flutter/material.dart';
import 'package:places/ui/res/theme_extension.dart';

/// Маркер текущего местоположения.
class LocationMarker extends StatelessWidget {
  const LocationMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (_, scale, child) => FractionallySizedBox(
        widthFactor: scale,
        heightFactor: scale,
        child: child,
      ),
      child: ClipOval(
        child: ColoredBox(
          color: theme.colorScheme.green.withOpacity(0.12),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.6,
            child: ClipOval(
              child: ColoredBox(
                color: theme.colorScheme.green.withOpacity(0.24),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.white,
                        width: 2.0,
                      ),
                      gradient: theme.fabGradient,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
