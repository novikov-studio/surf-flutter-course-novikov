import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';

/// Виджет "Плавающая кнопка" с градиентным фоном.
class GradientFab extends StatelessWidget {
  final String label;
  final double elevation;
  final VoidCallback? onPressed;

  const GradientFab({
    Key? key,
    required this.label,
    this.elevation = 0.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait = context.isPortrait;

    return Container(
      decoration: BoxDecoration(
        gradient: theme.fabGradient,
        borderRadius: const BorderRadius.all(Radius.circular(48.0)),
        boxShadow: elevation > 0
            ? const [
                BoxShadow(
                  blurRadius: 16.0,
                  offset: Offset(0.0, 4.0),
                  color: Color(0x411A1A20),
                ),
              ]
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: RawMaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(
          horizontal: isPortrait ? 22.0 : 15.0,
          vertical: 15.0,
        ),
        constraints: const BoxConstraints(),
        elevation: elevation,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgIcon(AppIcons.plus),
            if (isPortrait) ...[
              spacerW8,
              Text(
                label,
                style: theme.buttonWhite,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
