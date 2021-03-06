import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_wm.dart';
import 'package:places/ui/screen/sight_card/widget/svg_button.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/spacers.dart';
import 'package:provider/provider.dart';

/// Верхняя часть карточки места.
class SightCardImage extends StatelessWidget {
  const SightCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wm = context.read<ISightCardWidgetModel>();
    final sight = wm.sightState.value!;
    const animDuration = Duration(milliseconds: 250);

    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: sight.id,
          child:
              DarkenImage(url: sight.urls.isNotEmpty ? sight.urls.first : ''),
        ),
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Text(
            sight.type.title,
            style: Theme.of(context).smallBoldWhite,
          ),
        ),
        Positioned(
          top: 8.0,
          right: 16.0,
          child: StateNotifierBuilder<Sight>(
            listenableState: wm.sightState,
            builder: (context, sight) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Кнопка "Запланировать"
                  AnimatedOpacity(
                    opacity: sight!.isLiked && !sight.isVisited ? 1.0 : 0.0,
                    duration: animDuration,
                    child: IgnorePointer(
                      ignoring: !(sight.isLiked && !sight.isVisited),
                      child: SvgButton(
                        path: AppIcons.calendar,
                        onPressed: wm.planVisiting,
                      ),
                    ),
                  ),

                  /// Кнопка "Поделиться"
                  // TODO(novikov): Добавить анимацию появления/скрытия
                  if (sight.isVisited)
                    SvgButton(
                      path: AppIcons.share,
                      onPressed: () {
                        debugPrint('card.share');
                      },
                    ),

                  spacerW8,

                  /// Кнопка "Избранное" - добавить/удалить
                  AnimatedCrossFade(
                    firstChild: SvgButton(
                      path: AppIcons.heart,
                      onPressed: wm.toggleInFavorites,
                    ),
                    secondChild: SvgButton(
                      path: wm.mode == CardMode.favorites
                          ? AppIcons.close
                          : AppIcons.heartFilled,
                      onPressed: wm.toggleInFavorites,
                    ),
                    crossFadeState: sight.isLiked
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: animDuration,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
