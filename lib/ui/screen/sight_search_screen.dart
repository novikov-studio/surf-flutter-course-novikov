import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/search_history_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/service/utils.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/widget/controls/darken_image.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/search_bar.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/search_history.dart';

/// Экран "Поиск мест" по названию.
///
/// Содержимое зависит от состояния [_SightSearchScreenState._state] типа [SearchState].
/// При входе на экран отображается история поиска [SearchHistory],
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
                return SearchHistory(
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
                return const Loader();

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
      return;
    }
    _lastSearch = text;

    // Если поле пустое, показыаем историю
    if (text.trim().isEmpty) {
      _delayedSearch.cancel();
      _state.value = SearchState.initial;
    } // Если ввели целое слово, сразу начинаем поиск
    else if (text.endsWith(' ')) {
      _delayedSearch.cancel();
      _search(text.trimRight());
    } // Отложенный поиск
    else {
      _delayedSearch(text);
    }
  }

  /// Поиск мест по подстроке.
  Future<void> _search(String text) async {
    // Добавляем запрос в историю поиска
    await _historyProvider.add(text);

    // Переходим в состояние поиска
    _state.value = SearchState.inProgress;

    // Производим поиск
    try {
      _filtered = widget.sights.where((e) => e.isMatch(text)).toList(
            growable: false,
          );

      // Если за время поиска успели очистить поле ввода,
      // значит результат уже не интересен, отображаем историю
      _state.value = _controller.text.isEmpty
          ? SearchState.initial
          : _filtered.isEmpty
              ? SearchState.empty
              : SearchState.found;
    } on Exception catch (e) {
      Utils.log(e.toString());
      _state.value = SearchState.error;
    }
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