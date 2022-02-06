import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';

class SightCardImage extends StatelessWidget {
  final Sight sight;
  final CardMode mode;

  const SightCardImage({
    Key? key,
    required this.sight,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DarkenImage(url: sight.url),
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Text(
            sight.type,
            style: Theme.of(context).smallBoldWhite,
          ),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Кнопка "Запланировать"
              if (sight.isLiked && sight.isPlanned)
                const _SvgButton(
                  // TODO(novikov): Обработчик нажатия иконки "Запланировать"
                  path: AppIcons.calendar,
                ),

              /// Кнопка "Поделиться"
              if (sight.isVisited)
                const _SvgButton(
                  // TODO(novikov): Обработчик нажатия иконки "Поделиться"
                  path: AppIcons.share,
                ),

              spacerW16,

              /// Кнопка "Избранное" - добавить/удалить
              _SvgButton(
                // TODO(novikov): Обработчик нажатия иконки "Избранное"
                path: sight.isLiked
                    ? (mode == CardMode.favorites
                        ? AppIcons.close
                        : AppIcons.heartFilled)
                    : AppIcons.heart,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SvgButton extends StatelessWidget {
  final String path;
  final VoidCallback? onTap;

  const _SvgButton({Key? key, required this.path, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      color: Theme.of(context).colorScheme.white,
    );
  }
}
