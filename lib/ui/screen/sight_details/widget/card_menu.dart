import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details/sight_details_wm.dart';
import 'package:places/ui/widget/svg_text_button.dart';
import 'package:provider/provider.dart';

/// Блок нижних кнопок на экране "Детализация".
class CardMenu extends StatelessWidget {
  const CardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wm = context.read<ISightDetailsWidgetModel>();

    return StateNotifierBuilder<Sight>(
      listenableState: wm.sightState,
      builder: (context, sight) {
        return Row(
          children: [
            /// Кнопка слева (один из трех вариантов)
            if (sight!.isPlanned)
              Expanded(
                child: SvgTextButton(
                  icon: AppIcons.calendarFill,
                  label: sight.plannedDate!.toDateOnlyString(),
                  color: theme.colorScheme.green,
                  onPressed: wm.planVisiting,
                ),
              ),
            if (sight.isVisited)
              Expanded(
                child: SvgTextButton(
                  icon: AppIcons.share,
                  label: AppStrings.share,
                  onPressed: () {
                    debugPrint('details.share');
                  },
                ),
              ),
            if (!sight.isPlanned && !sight.isVisited)
              Expanded(
                child: SvgTextButton(
                  icon: AppIcons.calendar,
                  label: AppStrings.schedule,
                  onPressed: sight.isLiked ? wm.planVisiting : null,
                ),
              ),

            /// Кнопка справа
            Expanded(
              child: SvgTextButton(
                icon: sight.isLiked ? AppIcons.heartFilled : AppIcons.heart,
                label: AppStrings.addFavorites,
                onPressed: wm.toggleInFavorites,
              ),
            ),
          ],
        );
      },
    );
  }
}
