import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/gradient_progress_indicator.dart';

/// Индикатор выполнения операции.
class Loader extends StatelessWidget {
  final bool large;

  const Loader({Key? key, this.large = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: large ? SizedBox(
        width: 144.0,
        height: 144.0,
        child: GradientProgressIndicator(
          colors: [theme.colorScheme.yellow, theme.colorScheme.green],
          stops: const [0.0, 0.5],
          strokeWidth: 16.0,
        ),
      ) : SizedBox(
        width: 40.0,
        height: 40.0,
        child: GradientProgressIndicator(
          colors: [theme.colorScheme.surface, theme.colorScheme.secondary2],
          stops: const [0.0, 0.5],
          strokeWidth: 6.0,
        ),
      ),
    );
  }
}
