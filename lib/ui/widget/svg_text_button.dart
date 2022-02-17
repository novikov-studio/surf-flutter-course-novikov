import 'package:flutter/material.dart';
import 'package:places/ui/widget/svg_icon.dart';

class SvgTextButton extends StatelessWidget {
  final String label;
  final String? icon;
  final Color? color;
  final VoidCallback? onPressed;

  const SvgTextButton({
    Key? key,
    this.icon,
    required this.label,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = color != null
        ? TextButton.styleFrom(
            primary: color,
          )
        : null;

    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            icon: SvgIcon(icon!),
            label: Text(label),
            style: style,
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            style: style,
          );
  }
}
