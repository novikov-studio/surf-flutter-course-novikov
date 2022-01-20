import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_strings.dart';

class SightDetailsText extends StatelessWidget {
  static const _titleStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  static const _smallBoldStyle = TextStyle(
    color: AppColors.secondary,
    fontWeight: FontWeight.bold,
  );

  static const _small2Style = TextStyle(
    color: AppColors.secondary2,
  );

  static const _smallStyle = TextStyle(
    color: AppColors.secondary,
  );

  static const _buttonStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  static const _spacer = SizedBox(height: 24.0);

  final Sight sight;

  const SightDetailsText({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatStyle = TextButton.styleFrom(
      primary: AppColors.secondary,
      padding: const EdgeInsets.symmetric(vertical: 11.0),
    );

    final coloredStyle = TextButton.styleFrom(
      primary: AppColors.white,
      backgroundColor: AppColors.green,
      padding: const EdgeInsets.all(15.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sight.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _titleStyle,
          ),
          Wrap(
            children: [
              Text(sight.type, style: _smallBoldStyle),
              if (sight.info != null) Text(sight.info!, style: _small2Style),
            ],
            spacing: 16.0,
          ),
          if (sight.details != null) ...[
            _spacer,
            Text(
              sight.details!.trimRight(),
              style: _smallStyle,
            ),
          ],
          _spacer,
          TextButton.icon(
            onPressed: () {
              // TODO(novikov): Обработчик нажатия кнопки "Построить маршрут"
            },
            icon: const Icon(Icons.navigation),
            label: const Text(sBuildRoute, style: _buttonStyle),
            style: coloredStyle,
          ),
          _spacer,
          const Divider(
            height: 0.8,
            color: AppColors.divider,
          ),
          const SizedBox(width: 8.0),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.calendar_view_month),
                  label: const Text(sSchedule),
                  style: flatStyle,
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO(novikov): Добавление в Избранное
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text(sAddFavorites),
                  style: flatStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
