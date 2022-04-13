import 'package:flutter/material.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/spacers.dart';
import 'package:places/ui/widget/controls/svg_icon.dart';
import 'package:places/ui/widget/controls/svg_text_button.dart';

/// Виджет для отображения истории поиска.
///
/// Используется на экране [SightSearchScreen].
class SearchHistory extends StatefulWidget {
  final void Function(String) onItemTap;

  const SearchHistory({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closeColor = theme.colorScheme.isLight
        ? theme.colorScheme.inactiveBlack
        : theme.colorScheme.secondary2;

    final searchInteractor = context.searchInteractor;

    final clearLink = Transform.translate(
      offset: const Offset(-8.0, 0.0),
      child: SvgTextButton.link(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        label: AppStrings.clearHistory,
        color: theme.colorScheme.green,
        onPressed: () => _clearHistory(context),
      ),
    );

    return FutureBuilder<List<String>>(
      future: searchInteractor.getHistory(),
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
        return Builder(
          builder: (context) {
            final items = snapshot.data!;
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
                                  _removeFromHistory(context, items[index]),
                            ),
                            onTap: () => widget.onItemTap(items[index]),
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
      },
    );
  }

  Future<void> _removeFromHistory(BuildContext context, String value) async {
    await context.searchInteractor.removeFromHistory(value);
    _reload();
  }

  Future<void> _clearHistory(BuildContext context) async {
    await context.searchInteractor.clearHistory();
    _reload();
  }

  void _reload() {
    // ignore: no-empty-block
    setState((){});
  }
}
