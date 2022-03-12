import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widget/sight_card_image.dart';
import 'package:places/ui/widget/sight_card_text.dart';

/// Виджет карточки места.
class SightCard extends StatelessWidget {
  final Sight sight;
  final CardMode mode;
  final bool draggable;

  const SightCard({
    Key? key,
    required this.sight,
    required this.mode,
    this.draggable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      child: InkWell(
        onTap: () {
          context.pushScreen<SightDetails>(
            (context) => SightDetails(sight: sight),
          );
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

    return card;
  }
}

enum CardMode { list, map, favorites }
