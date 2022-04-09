import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';
import 'package:places/ui/widget/sight_card_image.dart';
import 'package:provider/provider.dart';

/// Текстовая часть экрана [SightDetails].
class SightDetailsText extends StatelessWidget {
  const SightDetailsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sight = context.watch<SightNotifier>().value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spacerH24,
          Text(
            sight.name,
            style: theme.titleOnSurface,
          ),
          Wrap(
            children: [
              Text(
                sight.type,
                style: theme.smallBoldForDetailsType,
              ),
              if (sight.info != null)
                Text(sight.info!, style: theme.smallForDetailsInfo),
            ],
            spacing: 16.0,
          ),
          if (sight.details != null) ...[
            spacerH24,
            Text(
              sight.details!.trimRight(),
              style: theme.smallOnSurface,
            ),
          ],
          spacerH24,
          _GoRouteButton(sight: sight),
          spacerH24,
          const Divider(),
          spacerH8,
          _CardMenu(sight: sight),
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
    final theme = Theme.of(context);

    return sight.isVisited
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: null,
                  icon: const SvgIcon(AppIcons.tick),
                  label: const Text(AppStrings.doneRoute),
                  style: theme.btnVisited,
                ),
              ),
              spacerW16,
              ElevatedButton(
                onPressed: () {
                  Utils.logButtonPressed('details.goRoute.small');
                },
                child: const SvgIcon(AppIcons.goRoute),
              ),
            ],
          )
        : ElevatedButton.icon(
            onPressed: () {
              Utils.logButtonPressed('details.goRoute.big');
            },
            icon: const SvgIcon(AppIcons.goRoute),
            label: const Text(AppStrings.buildRoute),
          );
  }
}

class _CardMenu extends StatelessWidget {
  final Sight sight;

  const _CardMenu({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        /// Кнопка слева (один из трех вариантов)
        if (sight.isPlanned)
          Expanded(
            child: SvgTextButton(
              icon: AppIcons.calendarFill,
              label: sight.plannedDate!.toDateOnlyString(),
              color: theme.colorScheme.green,
              onPressed: () => _planVisiting(context),
            ),
          ),
        if (sight.isVisited)
          Expanded(
            child: SvgTextButton(
              icon: AppIcons.share,
              label: AppStrings.share,
              onPressed: () {
                Utils.logButtonPressed('details.share');
              },
            ),
          ),
        if (!sight.isPlanned && !sight.isVisited)
          Expanded(
            child: SvgTextButton(
              icon: AppIcons.calendar,
              label: AppStrings.schedule,
              onPressed: sight.isLiked ? () => _planVisiting(context) : null,
            ),
          ),

        /// Кнопка справа
        Expanded(
          child: SvgTextButton(
            icon: sight.isLiked ? AppIcons.heartFilled : AppIcons.heart,
            label: AppStrings.addFavorites,
            onPressed: () => _toggleInFavorites(context),
          ),
        ),
      ],
    );
  }

  Future<void> _toggleInFavorites(BuildContext context) async =>
      SightCardImage.toggleInFavorites(context, sight);

  Future<void> _planVisiting(BuildContext context) async =>
      SightCardImage.planVisiting(context, sight);
}
