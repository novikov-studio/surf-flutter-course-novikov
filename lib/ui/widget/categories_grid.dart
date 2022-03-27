import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/responsive.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth / 3;

        final categories = Categories.items.entries
            .expand(
              (e) => [
                _CategoryCell(
                  category: _Category(e.key, e.value),
                  isChecked: checked.contains(e.key),
                  width: size,
                  onPressed: onCategoryPressed,
                ),
              ],
            )
            .toList(growable: false);

        return HandsetAdapter(
          small: (_) => SizedBox(
            height: size * 1.1,
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              childAspectRatio: (size * 1.1) / size,
              children: categories,
            ),
          ),
          orElse: (_) => GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 0.8,
            children: categories,
          ),
        );
      },
    );
  }
}

/// Виджет для отображения ячейки категории.
class _CategoryCell extends StatelessWidget {
  final _Category category;
  final bool isChecked;
  final double width;
  final CategoryPressedCallback onPressed;

  const _CategoryCell({
    Key? key,
    required this.category,
    required this.isChecked,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = width * 0.6;

    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              Positioned.fill(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(size)),
                  onTap: () {
                    onPressed(category.title, !isChecked);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.green.withOpacity(0.16),
                    ),
                    child: Center(
                      child: SvgIcon(
                        category.icon,
                        size: size * 0.5,
                        color: theme.colorScheme.green,
                      ),
                    ),
                  ),
                ),
              ),
              if (isChecked)
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: _Badge(size: size * 0.25),
                ),
            ],
          ),
        ),
        spacerH12,
        Text(
          category.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: Theme.of(context).textTheme.superSmall,
        ),
      ],
    );
  }
}

/// Чекбокс на иконке категории.
class _Badge extends StatelessWidget {
  final double size;

  const _Badge({Key? key, required this.size}) : super(key: key);

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
        size: size,
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
