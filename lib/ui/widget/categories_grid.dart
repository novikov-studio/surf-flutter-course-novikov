import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';

typedef CategoryPressedCallback = void Function(
  String category,
  bool isChecked,
);

/// Виджет для отображения таблицы категорий на экране [FiltersScreen].
class CategoriesGrid extends StatelessWidget {
  final Set<String> checked;
  final CategoryPressedCallback onCategoryPressed;

  const CategoriesGrid({
    Key? key,
    required this.checked,
    required this.onCategoryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: Categories.items.entries
          .map(
            (e) => _CategoryCell(
              category: _Category(e.key, e.value),
              isChecked: checked.contains(e.key),
              onPressed: onCategoryPressed,
            ),
          )
          .toList(growable: false),
    );
  }
}

/// Виджет для отображения ячейки категории.
class _CategoryCell extends StatelessWidget {
  final _Category category;
  final bool isChecked;
  final CategoryPressedCallback onPressed;

  const _CategoryCell({
    Key? key,
    required this.category,
    required this.isChecked,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(64.0)),
            onTap: () {
              onPressed(category.title, !isChecked);
            },
            child: _CategoryIcon(
              icon: category.icon,
            ),
          ),
          if (isChecked)
            const Positioned(
              bottom: 0.0,
              right: 0.0,
              child: _Badge(),
            ),
        ]),
        spacerH12,
        Text(
          category.title,
          style: Theme.of(context).textTheme.superSmall,
        ),
      ],
    );
  }
}

/// Иконка категории.
class _CategoryIcon extends StatelessWidget {
  final String icon;

  const _CategoryIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.green.withOpacity(0.16),
      ),
      child: SvgIcon(
        icon,
        size: 32.0,
        color: theme.colorScheme.green,
      ),
    );
  }
}

/// Чекбокс на иконке категории.
class _Badge extends StatelessWidget {
  const _Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.onBackground,
      ),
      child: SvgIcon(
        AppIcons.tick,
        color: theme.colorScheme.background,
        size: 16.0,
      ),
    );
  }
}

/// Служебный класс для хранения информации о категории.
class _Category {
  final String title;
  final String icon;

  const _Category(this.title, this.icon);
}
