import 'package:flutter/material.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';

/// Кнопка в виде svg-иконки.
class SvgButton extends IconButton {
  SvgButton({
    Key? key,
    required String path,
    required VoidCallback? onPressed,
  }) : super(
          key: key,
          onPressed: onPressed,
          icon: SvgIcon(path),
          splashRadius: 20.0,
          constraints: const BoxConstraints(minWidth: 24.0, minHeight: 24.0),
        );
}
