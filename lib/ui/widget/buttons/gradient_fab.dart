import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/svg_icon.dart';

class GradientFab extends StatelessWidget {
  final double elevation;
  final VoidCallback? onPressed;

  const GradientFab({
    Key? key,
    this.elevation = 0.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
        elevation: elevation,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgIcon(AppIcons.plus),
            spacerW8,
            Text(
              AppStrings.newSight.toUpperCase(),
              style: theme.buttonWhite,
            ),
          ],
        ),
      ),
    );
  }
}
