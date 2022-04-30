import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/screen/filters_screen/filters_screen_wm.dart';
import 'package:places/ui/screen/res/responsive.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:provider/provider.dart';

/// Виджет для отображения таблицы категорий на экране "Фильтры".
class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth / 3;

        final categories = Category.values
            .expand(
              (e) => [
                _CategoryCell(
                  category: e,
                  width: size,
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
  final Category category;
  final double width;

  const _CategoryCell({
    Key? key,
    required this.category,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wm = context.read<IFiltersScreenWidgetModel>();

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
                  onTap: () => wm.toggleCategory(category),
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
              StateNotifierBuilder<Set<Category>>(
                listenableState: wm.categories,
                builder: (_, categories) =>
                    categories?.contains(category) ?? false
                        ? Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: _Badge(size: size * 0.25),
                          )
                        : const SizedBox.shrink(),
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
