import 'package:flutter/material.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';
import 'package:places/ui/widget/svg_text_button.dart';


class SimpleAppBar extends AppBar {
  SimpleAppBar({
    Key? key,
    String? title,
    String? leadingIcon,
    String? leadingText,
    VoidCallback? leadingOnTap,
    String? trailingIcon,
    String? trailingText,
    VoidCallback? trailingOnTap,
    PreferredSizeWidget? bottom,
  }) : super(
          key: key,
          title: title != null ? Text(title) : null,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: leadingIcon != null || leadingText != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _AppBarAction(
                      isLeading: true,
                      icon: leadingIcon,
                      text: leadingText,
                      onPressed: leadingOnTap,
                    ),
                  ],
                )
              : null,
          actions: trailingIcon != null || trailingText != null
              ? [
                  _AppBarAction(
                    isLeading: false,
                    icon: trailingIcon,
                    text: trailingText,
                    onPressed: trailingOnTap,
                  ),
                ]
              : null,
          leadingWidth: 120.0,
          bottom: bottom,
        );
}

class _AppBarAction extends StatelessWidget {
  final String? icon;
  final String? text;
  final bool isLeading;
  final VoidCallback? onPressed;

  const _AppBarAction({
    Key? key,
    required this.isLeading,
    this.icon,
    this.text,
    required this.onPressed,
  })  : assert(!(icon != null && text != null)),
        assert(!(icon == null && text == null)),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        isLeading ? theme.colorScheme.secondary2 : theme.colorScheme.green;

    return text != null
        // ignore: avoid-wrapping-in-padding
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgTextButton.link(
              label: text!,
              color: color,
              padding: const EdgeInsets.all(8.0),
              onPressed: onPressed,
            ),
          )
        : IconButton(
            icon: SvgIcon(icon!),
            splashRadius: 20.0,
            onPressed: onPressed,
          );
  }
}
