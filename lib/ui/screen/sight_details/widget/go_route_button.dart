import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/spacers.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Кнопка "Построить маршрут".
class GoRouteButton extends StatelessWidget {
  final Sight sight;

  const GoRouteButton({Key? key, required this.sight}) : super(key: key);

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
            debugPrint('details.goRoute.small');
          },
          child: const SvgIcon(AppIcons.goRoute),
        ),
      ],
    )
        : ElevatedButton.icon(
      onPressed: () {
        debugPrint('details.goRoute.big');
      },
      icon: const SvgIcon(AppIcons.goRoute),
      label: const Text(AppStrings.buildRoute),
    );
  }
}
