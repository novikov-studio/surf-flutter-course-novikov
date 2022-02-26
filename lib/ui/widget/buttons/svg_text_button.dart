import 'package:flutter/material.dart';
import 'package:places/ui/widget/svg_icon.dart';

class SvgTextButton extends StatelessWidget {
  final String label;
  final String? icon;
  final Color? color;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;

  const SvgTextButton({
    Key? key,
    this.icon,
    required this.label,
    this.color,
    this.padding,
    this.focusNode,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = color != null || padding != null
        ? TextButton.styleFrom(
            primary: color,
            padding: padding,
          )
        : null;

    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            icon: SvgIcon(icon!),
            label: Text(label),
            focusNode: focusNode,
            style: style,
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(label),
            focusNode: focusNode,
            style: style,
          );
  }
}
