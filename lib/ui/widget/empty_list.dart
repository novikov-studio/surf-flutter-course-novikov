import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/spacers.dart';

/// Виджет для полноэкранного отображения ошибок и сообщений.
// Возможно, стоит переименовать.
class EmptyList extends StatelessWidget {
  /// Путь к svg-изображению в ресурсах.
  final String icon;

  /// Основной текст.
  final String title;

  /// Текстовое пояснение.
  final String? details;

  final EdgeInsets? padding;

  const EmptyList({
    Key? key,
    required this.icon,
    required this.title,
    this.details,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: padding,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 64.0,
              height: 64.0,
              color: theme.colorScheme.inactiveBlack,
            ),
            spacerH24,
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.subtitleInactiveBlack,
            ),
            if (details != null) ...[
              spacerH8,
              Text(
                details!,
                textAlign: TextAlign.center,
                style: theme.smallInactiveBlack,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
