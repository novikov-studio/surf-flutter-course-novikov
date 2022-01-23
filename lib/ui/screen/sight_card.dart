import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/widget/favorites_icon.dart';
import 'package:places/ui/widget/sight_card_image.dart';
import 'package:places/ui/widget/sight_card_text.dart';

/// Виджет карточки места.
class SightCard extends StatelessWidget {
  final Sight sight;

  /// Максимальное кол-во строк заголовка.
  final int titleMaxLines;

  /// Если задан обработчик [onButtonPressed], в правом нижнем углу отрисовывается кнопка.
  final VoidCallback? onButtonPressed;

  /// Обработчик нажатия на иконку Избранное.
  final VoidCallback? onLikeToggle;

  /// Обработчик нажатия на саму карточку.
  final VoidCallback? onTap;

  const SightCard({
    Key? key,
    required this.sight,
    this.onButtonPressed,
    this.onLikeToggle,
    this.onTap,
    this.titleMaxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16.0),
            bottom: Radius.circular(12.0),
          ),
          child: Container(
            color: AppColors.cardBackground,
            child: Column(
              children: [
                SizedBox(
                  height: 96.0,
                  child: SightCardImage(
                    url: sight.url,
                    category: sight.type,
                    icon: FavoritesIcon(
                      liked: sight.liked,
                      onTap: onLikeToggle,
                    ),
                  ),
                ),
                SightCardText(
                  title: sight.name,
                  subtitle: sight.brief,
                  titleMaxLines: titleMaxLines,
                  // TODO(novikov): использовать [intl]
                  banner: sight.planned != null
                      ? 'Запланировано на ${sight.planned}'
                      : null,
                  onButtonPressed: onButtonPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
