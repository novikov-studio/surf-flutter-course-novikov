import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Виджет для вызова диалогов фильтров и поиска.
class InactiveSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ListenableState<bool> filterState;
  final VoidCallback? onFieldTap;
  final VoidCallback? onIconTap;
  final SearchBar searchBar;

  @override
  Size get preferredSize => searchBar.preferredSize;

  const InactiveSearchBar({
    Key? key,
    required this.filterState,
    required this.searchBar,
    this.onFieldTap,
    this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        GestureDetector(
          child: const SearchBar(enabled: false),
          onTap: onFieldTap,
        ),
        Positioned(
          right: 16.0,
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: StateNotifierBuilder<bool>(
                listenableState: filterState,
                builder: (_, filterIsEmpty) {
                  return SvgIcon(
                    AppIcons.filter,
                    color: filterIsEmpty ?? true
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.green,
                  );
                },
              ),
              splashRadius: 20.0,
              onPressed: onIconTap,
            ),
          ),
        ),
      ],
    );
  }
}
