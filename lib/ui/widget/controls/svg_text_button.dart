import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';

class SvgTextButton extends StatelessWidget {
  final String label;
  final String? icon;
  final Color? color;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;
  final _Mode _mode;

  const SvgTextButton({
    Key? key,
    this.icon,
    required this.label,
    this.color,
    this.padding,
    this.focusNode,
    this.onPressed,
  })  : _mode = _Mode.button,
        super(key: key);

  const SvgTextButton.link({
    Key? key,
    required this.label,
    this.color,
    this.padding,
    this.onPressed,
  })  : icon = null,
        focusNode = null,
        _mode = _Mode.text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        _mode == _Mode.text ? Theme.of(context).textTheme.text : null;

    final style = color != null || padding != null || textStyle != null
        ? TextButton.styleFrom(
            primary: color,
            padding: padding,
            textStyle: textStyle,
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

enum _Mode { button, text }
