import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';

class EmptyList extends StatelessWidget {
  /// Путь к svg-изображению в ресурсах.
  final String icon;

  /// Основной текст.
  final String title;

  /// Текстовое пояснение.
  final String? details;

  const EmptyList({
    Key? key,
    required this.icon,
    required this.title,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 64.0,
            height: 64.0,
            color: Theme.of(context).colorScheme.inactiveBlack,
          ),
          spacerH24,
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).subtitleInactiveBlack,
          ),
          if (details != null) ...[
            spacerH8,
            Text(
              details!,
              textAlign: TextAlign.center,
              style: Theme.of(context).smallInactiveBlack,
            ),
          ],
        ],
      ),
    );
  }
}
