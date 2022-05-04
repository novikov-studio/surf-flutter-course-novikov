import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/spacers.dart';

/// Виджет для отображения шагов онбординга.
class StepPage extends StatelessWidget {
  final String icon;
  final String title;
  final String details;
  final bool isLast;
  final VoidCallback onStart;

  const StepPage({
    Key? key,
    required this.icon,
    required this.title,
    required this.details,
    required this.onStart,
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
              SvgPicture.asset(
                icon,
                width: 104.0,
                height: 104.0,
                color: theme.colorScheme.onBackground,
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
