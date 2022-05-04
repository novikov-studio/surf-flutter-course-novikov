import 'package:flutter/material.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/screen/onboarding_screen/widget/animated_svg_icon.dart';
import 'package:places/ui/widget/spacers.dart';

/// Виджет для отображения шагов онбординга.
class StepPage extends StatelessWidget {
  final String icon;
  final String title;
  final String details;
  final int index;
  final bool isLast;
  final VoidCallback onStart;

  const StepPage({
    Key? key,
    required this.icon,
    required this.title,
    required this.details,
    required this.onStart,
    required this.index,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSvgIcon(
                icon: icon,
                size: 104.0,
                color: theme.colorScheme.onBackground,
                index: index,
              ),
              spacerH48,
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.titleOnBackground,
              ),
              spacerH8,
              Text(
                details,
                textAlign: TextAlign.center,
                style: theme.smallSecondary2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLast
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                child: const Text(AppStrings.start),
                onPressed: onStart,
              ),
            )
          : null,
    );
  }
}
