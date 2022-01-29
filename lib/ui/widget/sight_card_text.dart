import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/app_colors.dart';
import 'package:places/ui/app_strings.dart';
import 'package:places/ui/app_styles.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightCardText extends StatelessWidget {
  final Sight sight;
  final CardMode mode;

  const SightCardText({
    Key? key,
    required this.sight,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sight.name,
                  maxLines: mode == CardMode.map ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: text,
                ),
                if (sight.isPlanned || sight.isVisited)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
                    child: Text(
                      _formatEvent(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: sight.isPlanned ? smallGreen : smallSecondary2,
                    ),
                  ),
                if (sight.brief != null) ...[
                  const SizedBox(height: 2.0),
                  Text(
                    sight.brief!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: smallSecondary2,
                  ),
                ],
              ],
            ),
          ),
          if (mode == CardMode.map)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: TextButton(
                  // TODO(novikov): Обработчик нажатия кнопки "Построить маршрут"
                  onPressed: null,
                  child: const Icon(Icons.navigation),
                  style: TextButton.styleFrom(
                    primary: AppColors.white,
                    backgroundColor: AppColors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatEvent() {
    assert(sight.plannedDate != null || sight.visitedDate != null);

    return sight.isVisited
        ? AppStrings.visitedOn
            .replaceFirst('%s', sight.visitedDate!.toDateOnlyString())
        : AppStrings.scheduledFor
            .replaceFirst('%s', sight.plannedDate!.toDateOnlyString());
  }
}

// Показалось излишним подключать intl ради одной функции
extension DateTimeExt on DateTime {
  /// Перевод в строку вида: "dd MMM yyyy"
  String toDateOnlyString() {
    final _day = day.toString().padLeft(2, '0');
    final _month = AppStrings.months[month - 1];

    return '$_day $_month $year';
  }
}
