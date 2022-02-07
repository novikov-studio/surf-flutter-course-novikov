import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/common.dart';

class SightDetailsText extends StatelessWidget {
  final Sight sight;

  const SightDetailsText({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            sight.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).titleOnSurface,
          ),
          Wrap(
            children: [
              Text(
                sight.type,
                style: Theme.of(context).smallBoldForDetailsType,
              ),
              if (sight.info != null)
                Text(sight.info!, style: Theme.of(context).smallForDetailsInfo),
            ],
            spacing: 16.0,
          ),
          if (sight.details != null) ...[
            spacerH24,
            Text(
              sight.details!.trimRight(),
              style: Theme.of(context).smallOnSurface,
            ),
          ],
          spacerH24,
          _GoRouteButton(sight: sight),
          spacerH24,
          const Divider(),
          spacerH8,
          _BottomButtons(sight: sight),
        ],
      ),
    );
  }
}

class _GoRouteButton extends StatelessWidget {
  final Sight sight;

  const _GoRouteButton({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sight.isVisited
        ? Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    AppIcons.tick,
                    color: Theme.of(context).colorScheme.green,
                  ),
                  label: Text(
                    AppStrings.doneRoute,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.green),
                  ),
                  style: _buildGreenButtonStyle(context, enabled: false),
                ),
              ),
              spacerW16,
              TextButton(
                onPressed: () {
                  // TODO(novikov): Обработчик нажатия кнопки "Построить маршрут"
                },
                child: SvgPicture.asset(
                  AppIcons.goRoute,
                  color: Theme.of(context).colorScheme.white,
                ),
                style: _buildGreenButtonStyle(context, enabled: true),
              ),
            ],
          )
        : TextButton.icon(
            onPressed: () {
              // TODO(novikov): Обработчик нажатия кнопки "Построить маршрут"
            },
            icon: SvgPicture.asset(
              AppIcons.goRoute,
              color: Theme.of(context).colorScheme.white,
            ),
            label: Text(
              AppStrings.buildRoute,
              style: Theme.of(context).buttonWhite,
            ),
            style: _buildGreenButtonStyle(context, enabled: true),
          );
  }

  ButtonStyle _buildGreenButtonStyle(
    BuildContext context, {
    required bool enabled,
  }) =>
      TextButton.styleFrom(
        primary: enabled
            ? Theme.of(context).colorScheme.white
            : Theme.of(context).colorScheme.green,
        backgroundColor: enabled
            ? Theme.of(context).colorScheme.green
            : Theme.of(context).cardColor,
        padding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        textStyle: enabled
            ? Theme.of(context).buttonWhite
            : Theme.of(context).buttonGreen,
        minimumSize: Size.zero,
      );
}

class _BottomButtons extends StatelessWidget {
  final Sight sight;

  const _BottomButtons({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Кнопка слева (один из трех вариантов)
        if (sight.isPlanned)
          Expanded(
            child: _SvgFlatButton(
              icon: AppIcons.calendarFill,
              label: sight.plannedDate!.toDateOnlyString(),
              color: Theme.of(context).colorScheme.green,
              onPressed: () {
                // TODO(novikov):  Обработчик нажатия кнопки пере-"Запланировать"
              },
            ),
          ),
        if (sight.isVisited)
          Expanded(
            child: _SvgFlatButton(
              icon: AppIcons.share,
              label: AppStrings.share,
              color: Theme.of(context).colorScheme.onSurface,
              onPressed: () {
                // TODO(novikov):  Обработчик нажатия кнопки "Поделиться"
              },
            ),
          ),
        if (!sight.isPlanned && !sight.isVisited)
          Expanded(
            child: _SvgFlatButton(
              icon: AppIcons.calendar,
              label: AppStrings.schedule,
              color: sight.isLiked
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.inactiveBlack,
              onPressed: sight.isLiked
                  ? () {
                      // TODO(novikov):  Обработчик нажатия кнопки "Запланировать"
                    }
                  : null,
            ),
          ),

        /// Кнопка справа
        Expanded(
          child: _SvgFlatButton(
            icon: sight.isLiked ? AppIcons.heartFilled : AppIcons.heart,
            label: AppStrings.addFavorites,
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () {
              // TODO(novikov):  Обработчик нажатия кнопки "В Избранное"
            },
          ),
        ),
      ],
    );
  }
}

class _SvgFlatButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const _SvgFlatButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(icon, color: color),
      label: Text(label),
      style: TextButton.styleFrom(
        primary: color,
        textStyle: Theme.of(context).textTheme.small.copyWith(color: color),
        padding: const EdgeInsets.symmetric(vertical: 11.0),
      ),
    );
  }
}
