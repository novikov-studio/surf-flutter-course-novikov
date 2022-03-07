import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/search_history_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widget/buttons/svg_text_button.dart';
import 'package:places/ui/widget/common.dart';
import 'package:places/ui/widget/darken_image.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/simple_app_bar.dart';
import 'package:places/ui/widget/svg_icon.dart';

/// Экран "Поиск мест" по названию.
///
/// Содержимое зависит от состояния [_SightSearchScreenState._state] типа [SearchState].
/// При входе на экран отображается история поиска [_HistoryWidget],
/// она же отображается при очистке поля ввода.
/// Для возврата на предыдущий экран необходимо нажать иконку "Очистить" при пустом поле ввода.
class SightSearchScreen extends StatefulWidget {
  final List<Sight> sights;

  const SightSearchScreen({Key? key, required this.sights}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late final _DelayedSearch _delayedSearch;
  final _controller = TextEditingController();
  final _historyProvider = SearchHistoryProvider.createProvider();
  final _state = ValueNotifier<SearchState>(SearchState.initial);
  String? _lastSearch = '';
  Iterable<Sight> _filtered = List.empty();

  @override
  void initState() {
    super.initState();
    _delayedSearch = _DelayedSearch(milliseconds: 500, callback: _search);
    _controller.addListener(_onTextChange);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = SimpleAppBar(
      title: AppStrings.listTitle,
      bottom: SearchBar(
        controller: _controller,
      ),
    );

    // Нужно, чтобы отцентрировать по вертикали EmptyList
    EdgeInsets shift() => EdgeInsets.only(
          bottom:
              appBar.preferredSize.height + appBar.bottom!.preferredSize.height,
        );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: _state,
          builder: (context, state, _) {
            switch (state) {
              case SearchState.initial:
                return _HistoryWidget(
                  historyProvider: _historyProvider,
                  onItemTap: (text) {
                    _controller
                      ..text = text
                      ..selection = TextSelection(
                        baseOffset: text.length,
                        extentOffset: text.length,
                      );
                  },
                );

              case SearchState.inProgress:
                return const _ProgressWidget();

              case SearchState.found:
                final divider = Divider(
                  height: 0.8,
                  indent: 16 + 56 + 16,
                  endIndent: 16.0,
                  color: Theme.of(context).dividerColor,
                );

                // TODO(novikov): Напрашивается ListView.separated
                return SingleChildScrollView(
                  child: Column(
                    children: _filtered
                        .expand((sight) => [
                              if (sight != _filtered.first) divider,
                              _SightListTile(sight: sight),
                            ])
                        .toList(growable: false),
                  ),
                );

              case SearchState.empty:
                return EmptyList(
                  icon: AppIcons.searchBig,
                  title: AppStrings.nothingFound,
                  details: AppStrings.tryAnotherSearch,
                  padding: shift(),
                );

              case SearchState.error:
                return EmptyList(
                  icon: AppIcons.error,
                  title: AppStrings.error,
                  details: AppStrings.tryLater,
                  padding: shift(),
                );
            }

            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _delayedSearch.dispose();
    super.dispose();
  }

  /// Callback на изменение содержимого поля ввода.
  void _onTextChange() {
    final text = _controller.text;

    //Если ввели только 1-2 символа или текст не изменился, ничего не делаем
    if (text.isNotEmpty && text.length < 3 || text == _lastSearch) {
      Utils.log('do nothing');

      return;
    }
    _lastSearch = text;

    // Если поле пустое, показыаем историю
    if (text.trim().isEmpty) {
      Utils.log('empty text');
      _delayedSearch.cancel();
      _state.value = SearchState.initial;
    } // Если ввели целое слово, сразу начинаем поиск
    else if (text.endsWith(' ')) {
      Utils.log('search by word');
      _delayedSearch.cancel();
      _search(text.trimRight());
    } // Отложенный поиск
    else {
      Utils.log('delayed search');
      _delayedSearch(text);
    }
  }

  /// Поиск мест по подстроке.
  Future<void> _search(String text) async {
    Utils.log('async search start');
    // Добавляем запрос в историю поиска
    await _historyProvider.add(text);

    // Переходим в состояние поиска
    _state.value = SearchState.inProgress;

    // Производим поиск
    try {
      _filtered = widget.sights.where((e) => e.isMatch(text)).toList(
            growable: false,
          );

      // Проверка индикатора прогресса
      // await Future<void>.delayed(const Duration(seconds: 1));

      // Проверка обработки ошибок
      // throw Exception('testException');

      // Если за время поиска успели очистить поле ввода, то переходим в initial,
      // иначе показываем результат
      _state.value = _controller.text.isEmpty
          ? SearchState.initial
          : _filtered.isEmpty
              ? SearchState.empty
              : SearchState.found;
    } on Exception catch (e) {
      Utils.log(e.toString());
      _state.value = SearchState.error;
    }
    Utils.log('async search end');
  }
}

/// Виджет для отображения истории поиска.
class _HistoryWidget extends StatelessWidget {
  final SearchHistoryProvider historyProvider;
  final void Function(String) onItemTap;

  const _HistoryWidget({
    Key? key,
    required this.historyProvider,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<Iterable<String>>(
      future: historyProvider.items(),
      builder: (_, snapshot) {
        // Прогресс
        if (snapshot.connectionState != ConnectionState.done) {
          return const _ProgressWidget();
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
                                      icon: const SvgIcon(AppIcons.close),
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

/// Виджет места в результатах поиска.
class _SightListTile extends StatelessWidget {
  final Sight sight;

  const _SightListTile({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: DarkenImage(
        url: sight.url,
        size: const Size.square(56.0),
        borderRadius: 12.0,
      ),
      title: Text(sight.name, style: theme.textOnBackground),
      subtitle: Text(sight.type, style: theme.smallSecondary2),
      onTap: () => _showDetails(context),
    );
  }

  /// Показ экрана детализации.
  void _showDetails(BuildContext context) {
    context.pushScreen<SightDetails>(
      (context) => SightDetails(sight: sight),
    );
  }
}

/// Индикатор выполнения операции.
class _ProgressWidget extends StatelessWidget {
  const _ProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Класс для задержки реакции на изменение.
class _DelayedSearch {
  final void Function(String) callback;
  final Duration _delay;
  Timer? _timer;

  _DelayedSearch({
    required int milliseconds,
    required this.callback,
  }) : _delay = Duration(milliseconds: milliseconds);

  void call(String text) {
    _timer?.cancel();
    _timer = Timer(_delay, () {
      callback(text);
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  void dispose() {
    cancel();
  }
}

/// Состояния экрана поиска.
enum SearchState { initial, inProgress, found, empty, error }
