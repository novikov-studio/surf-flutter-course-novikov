import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen_wm.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';

/// Виджет для отображения истории поиска.
class SearchHistory extends StatelessWidget {
  final ISightSearchScreenWidgetModel wm;

  const SearchHistory({Key? key, required this.wm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final closeColor = wm.theme.colorScheme.isLight
        ? wm.theme.colorScheme.inactiveBlack
        : wm.theme.colorScheme.secondary2;

    final clearLink = Transform.translate(
      offset: const Offset(-8.0, 0.0),
      child: SvgTextButton.link(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        label: AppStrings.clearHistory,
        color: wm.theme.colorScheme.green,
        onPressed: wm.clearHistory,
      ),
    );

    return EntityStateNotifierBuilder<List<String>>(
      listenableEntityState: wm.historyState,
      loadingBuilder: (_, __) => const Loader(),
      builder: (_, items) {
        if (items?.isEmpty ?? true) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacerH24,
                  Text(
                    AppStrings.yourHistory,
                    style: wm.theme.superSmallInactiveBlack,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight - 100.0,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: items!.length,
                      itemBuilder: (_, index) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          items[index],
                          style: wm.theme.text400Secondary2,
                        ),
                        trailing: IconButton(
                          splashRadius: 20.0,
                          icon: SvgIcon(
                            AppIcons.close,
                            color: closeColor,
                          ),
                          onPressed: () => wm.removeFromHistory(items[index]),
                        ),
                        onTap: () => wm.searchFromHistory(items[index]),
                      ),
                      separatorBuilder: (_, index) => const Divider(),
                    ),
                  ),
                  clearLink,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
