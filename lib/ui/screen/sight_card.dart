import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/sight_card_image.dart';
import 'package:places/ui/widget/sight_card_text.dart';

/// Виджет карточки места.
class SightCard extends StatelessWidget {
  final Sight sight;
  final CardMode mode;

  const SightCard({
    Key? key,
    required this.sight,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final draggable = mode == CardMode.favorites;
    final dismissible = draggable;

    Widget card = Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          context.pushBottomSheet(AppRoutes.details, args: sight.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96.0,
              child: SightCardImage(
                sight: sight,
                mode: mode,
              ),
            ),
            SightCardText(
              sight: sight,
              mode: mode,
            ),
          ],
        ),
      ),
    );

    if (draggable) {
      card = LongPressDraggable<String>(
        child: card,
        data: sight.id,
        axis: Axis.vertical,
        childWhenDragging: const SizedBox(),
        feedback: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 16.0 * 2,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Opacity(opacity: 0.8, child: card),
          ),
        ),
      );
    }

    if (dismissible) {
      card = Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            child: Column(
              children: [
                const SvgIcon(AppIcons.bucket),
                spacerH8,
                Text(AppStrings.delete, style: theme.superSmall500White),
              ],
            ),
          ),
          Dismissible(
            child: card,
            key: ValueKey('dm_${sight.id}'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) =>
                SightCardImage.toggleInFavorites(context, sight),
          ),
        ],
      );
    }

    return card;
  }
}

enum CardMode { list, map, favorites }
