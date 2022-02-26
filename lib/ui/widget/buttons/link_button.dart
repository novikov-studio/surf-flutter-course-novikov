import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/theme_extension.dart';

class LinkButton extends StatelessWidget {
  final String label;
  final Color? color;
  final VoidCallback? onPressed;

  const LinkButton({
    Key? key,
    required this.label,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.text;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: color != null ? style.copyWith(color: color) : style,
      ),
    );
  }
}
