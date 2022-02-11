import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';

class SvgTextButton extends StatelessWidget {
  final String label;
  final String? icon;
  final Color? color;
  final VoidCallback? onPressed;

  const SvgTextButton({
    Key? key,
    required this.icon,
    required this.label,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            icon: SvgIcon(icon!),
            label: Text(label),
            style: color != null ? theme.btnMenuGreen : null,
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            style: color != null ? theme.btnMenuGreen : null,
          );
  }
}
