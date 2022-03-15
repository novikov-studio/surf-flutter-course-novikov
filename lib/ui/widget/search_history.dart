import 'package:flutter/material.dart';
import 'package:places/domain/search_history_provider.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';

/// Виджет для отображения истории поиска.
class SearchHistory extends StatelessWidget {
  final SearchHistoryProvider historyProvider;
  final void Function(String) onItemTap;

  const SearchHistory({
    Key? key,
    required this.historyProvider,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closeColor = theme.colorScheme.isLight
        ? theme.colorScheme.inactiveBlack
        : theme.colorScheme.secondary2;

    return FutureBuilder<Iterable<String>>(
      future: historyProvider.items(),
      builder: (_, snapshot) {
        // Прогресс
        if (snapshot.connectionState != ConnectionState.done) {
          return const Loader();
        }

        // Пустой экран
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox();
        }

        // Результат
        return AnimatedBuilder(
          animation: historyProvider,
          builder: (context, child) {
            final items = snapshot.data!.toList(growable: false);
            if (items.isEmpty) {
              return const SizedBox();
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
                        style: theme.superSmallInactiveBlack,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight - 100.0,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (_, index) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              items[index],
                              style: theme.text400Secondary2,
                            ),
                            trailing: IconButton(
                              splashRadius: 20.0,
                              icon: SvgIcon(
                                AppIcons.close,
                                color: closeColor,
                              ),
                              onPressed: () =>
                                  historyProvider.remove(items[index]),
                            ),
                            onTap: () => onItemTap(items[index]),
                          ),
                          separatorBuilder: (_, index) => const Divider(),
                        ),
                      ),
                      child!,
                    ],
                  );
                },
              ),
            );
          },
          child: Transform.translate(
            offset: const Offset(-8.0, 0.0),
            child: SvgTextButton.link(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              label: AppStrings.clearHistory,
              color: theme.colorScheme.green,
              onPressed: historyProvider.clear,
            ),
          ),
        );
      },
    );
  }
}
