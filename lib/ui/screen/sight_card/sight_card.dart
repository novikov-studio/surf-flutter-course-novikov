import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/sight_card_wm.dart';
import 'package:places/ui/screen/sight_card/widgets/sight_card_image.dart';
import 'package:places/ui/screen/sight_card/widgets/sight_card_text.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:provider/provider.dart';

/// Виджет "Карточка места".
class SightCard extends ElementaryWidget<ISightCardWidgetModel> {
  SightCard({
    Key? key,
    required Sight sight,
    required CardMode mode,
    WidgetModelFactory? wmFactory,
  }) : super(
          wmFactory ??
              (context) =>
                  defaultSightCardWidgetModelFactory(context, sight, mode),
          key: key,
        );

  @override
  Widget build(ISightCardWidgetModel wm) {
    final draggable = wm.mode == CardMode.favorites;
    final dismissible = draggable;
    final sight = wm.sightState.value!;

    Widget card = Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: wm.showDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 96.0,
              child: SightCardImage(),
            ),
            SightCardText(),
          ],
        ),
      ),
    );

    if (dismissible) {
      card = Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: wm.theme.colorScheme.error,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                  bottom: Radius.circular(12.0),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            child: Column(
              children: [
                const SvgIcon(AppIcons.bucket),
                spacerH8,
                Text(AppStrings.delete, style: wm.theme.superSmall500White),
              ],
            ),
          ),
          Dismissible(
            child: card,
            key: ValueKey('dm_${sight.id}'),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => wm.toggleInFavorites(),
          ),
        ],
      );
    }

    if (draggable) {
      final mediaQuery = wm.mediaQuery;
      final isPortrait = mediaQuery.orientation == Orientation.portrait;
      final maxWidth = isPortrait
          ? mediaQuery.size.width - 16.0 * 2
          : (mediaQuery.size.width - 16.0 * 3) / 2;

      card = LongPressDraggable<int>(
        child: card,
        data: sight.id,
        axis: isPortrait ? Axis.vertical : null,
        childWhenDragging: const SizedBox(),
        feedback: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Opacity(opacity: 0.8, child: card),
          ),
        ),
      );
    }

    return Provider<ISightCardWidgetModel>.value(
      value: wm,
      child: card,
    );
  }
}

enum CardMode { list, map, favorites }
