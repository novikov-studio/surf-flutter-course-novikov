import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/screen/sight_card/sight_card_wm.dart';
import 'package:provider/provider.dart';

/// Нижняя часть карточки места.
class SightCardText extends StatelessWidget {
  const SightCardText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wm = context.read<ISightCardWidgetModel>();
    final sight = wm.sightState.value!;

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
                  maxLines: wm.mode == CardMode.map ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: wm.theme.textOnSurface,
                ),
                StateNotifierBuilder<Sight>(
                  listenableState: wm.sightState,
                  builder: (_, sight) => sight!.isPlanned || sight.isVisited
                      ? Padding(
                          padding:
                              const EdgeInsets.only(top: 2.0, bottom: 10.0),
                          child: Text(
                            sight.isVisited
                                ? AppStrings.visitedOn(sight.visitedDate!)
                                : AppStrings.scheduledFor(sight.plannedDate!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: sight.isPlanned
                                ? wm.theme.smallGreen
                                : wm.theme.smallSecondary2,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                if (sight.brief != null) ...[
                  const SizedBox(height: 2.0),
                  Text(
                    sight.brief!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: wm.theme.smallSecondary2,
                  ),
                ],
              ],
            ),
          ),
          if (wm.mode == CardMode.map)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('card.goRoute');
                  },
                  child: const Text(AppIcons.goRoute),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
