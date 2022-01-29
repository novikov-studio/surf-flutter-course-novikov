import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/app_colors.dart';
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
      },
    );
  }
}

enum CardMode { list, map, favorites }
