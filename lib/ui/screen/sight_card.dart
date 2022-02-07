import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_details.dart';
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
    return Card(
      child: InkWell(
        onTap: () async {
          final style = Theme.of(context).appBarTheme.systemOverlayStyle;

          await Navigator.push(
            context,
            MaterialPageRoute<SightDetails>(
              builder: (context) => SightDetails(sight: sight),
            ),
          );

          if (style != null) {
            SystemChrome.setSystemUIOverlayStyle(style);
          }
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
  }
}

enum CardMode { list, map, favorites }
