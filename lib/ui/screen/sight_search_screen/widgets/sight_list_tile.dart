import 'package:flutter/material.dart';
import 'package:places/domain/entity/sight.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/darken_image.dart';

/// Виджет места в результатах поиска.
class SightListTile extends StatelessWidget {
  final Sight sight;
  final VoidCallback? onTap;

  const SightListTile({
    Key? key,
    required this.sight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: DarkenImage(
        url: sight.urls.isNotEmpty ? sight.urls.first : '',
        size: const Size.square(56.0),
        borderRadius: 12.0,
      ),
      title: Text(sight.name, style: theme.textOnBackground),
      subtitle: Text(sight.type.title, style: theme.smallSecondary2),
      onTap: onTap,
    );
  }
}
