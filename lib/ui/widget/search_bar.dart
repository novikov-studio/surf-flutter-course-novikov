import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';
import 'package:places/ui/widget/svg_icon.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController? controller;
  final bool enabled;
  final bool autofocus;

  @override
  Size get preferredSize => const Size(double.infinity, 40.0 + 8.0 * 2);

  const SearchBar({
    Key? key,
    this.controller,
    this.enabled = true,
    this.autofocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Theme(
        data: theme.searchBarTheme,
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          enabled: enabled,
          style: theme.text400OnSurface,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: SvgIcon(AppIcons.search),
            ),
            hintText: AppStrings.search,
            suffixIcon: enabled
                ? Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      icon: const SvgIcon(AppIcons.clear),
                      splashRadius: 20.0,
                      onPressed: () {
                        controller?.text.isEmpty ?? false
                            ? Navigator.pop(context)
                            : controller?.clear();
                      },
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
