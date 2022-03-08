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
            if (snapshot.data!.isEmpty) {
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
                        // TODO(novikov): ListView.separated
                        child: SingleChildScrollView(
                          child: Column(
                            children: ListTile.divideTiles(
                              tiles: snapshot.data!.map((e) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  e,
                                  style: theme.text400Secondary2,
                                ),
                                trailing: IconButton(
                                  splashRadius: 20.0,
                                  icon: SvgIcon(
                                    AppIcons.close,
                                    color: closeColor,
                                  ),
                                  onPressed: () =>
                                      historyProvider.remove(e),
                                ),
                                onTap: () => onItemTap(e),
                              )),
                              color: theme.dividerColor,
                            ).toList(growable: false),
                          ),
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
