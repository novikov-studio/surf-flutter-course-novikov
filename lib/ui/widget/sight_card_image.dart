import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/svg_icon.dart';

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
          top: 8.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Кнопка "Запланировать"
              if (sight.isLiked && sight.isPlanned)
                _SvgButton(
                  path: AppIcons.calendar,
                  onPressed: () {
                    Utils.logButtonPressed('card.plan');
                  },
                ),

              /// Кнопка "Поделиться"
              if (sight.isVisited)
                _SvgButton(
                  path: AppIcons.share,
                  onPressed: () {
                    Utils.logButtonPressed('card.share');
                  },
                ),

              spacerW8,

              /// Кнопка "Избранное" - добавить/удалить
              _SvgButton(
                path: sight.isLiked
                    ? (mode == CardMode.favorites
                        ? AppIcons.close
                        : AppIcons.heartFilled)
                    : AppIcons.heart,
                onPressed: () {
                  Utils.logButtonPressed('card.like');
                },
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
  final VoidCallback? onPressed;

  const _SvgButton({Key? key, required this.path, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgIcon(path),
      splashRadius: 20.0,
      constraints: const BoxConstraints(minWidth: 24.0, minHeight: 24.0),
    );
  }
}
