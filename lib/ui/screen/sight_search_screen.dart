import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/const/categories.dart';
import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:places/ui/redux/state/search_state.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/widget/controls/darken_image.dart';
import 'package:places/ui/widget/controls/loader.dart';
import 'package:places/ui/widget/controls/search_bar.dart';
import 'package:places/ui/widget/controls/simple_app_bar.dart';
import 'package:places/ui/widget/empty_list.dart';
import 'package:places/ui/widget/search_history.dart';
import 'package:redux/redux.dart';

/// Экран "Поиск мест" по названию.
///
/// Содержимое зависит от состояния [SearchState].
/// При входе на экран отображается история поиска [SearchHistory],
/// она же отображается при очистке поля ввода.
/// Для возврата на предыдущий экран необходимо нажать иконку "Очистить" при пустом поле ввода.
class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late final Store<AppState> _store;
  late final _DelayedSearch _delayedSearch;
  final _controller = TextEditingController();
  String? _lastSearch = '';

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
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
        child: StoreConnector<AppState, SearchState>(
          converter: (store) => store.state.searchState,
          builder: (context, state) {
            // Если за время поиска успели очистить поле ввода,
            // значит результат уже не интересен, отображаем историю
            final effectiveState =
                _controller.text.isEmpty ? const SearchState.initial() : state;

            return effectiveState.when(
              /// Начальное состояние
              initial: () => SearchHistory(
                onItemTap: (text) {
                  _controller
                    ..text = text
                    ..selection = TextSelection(
                      baseOffset: text.length,
                      extentOffset: text.length,
                    );
                },
              ),

              /// Поиск
              loading: () => const Loader(),

              /// Поиск завершен.
              found: (sights) => ListView.separated(
                itemCount: sights.length,
                itemBuilder: (_, index) => _SightListTile(
                  sight: sights[index],
                ),
                separatorBuilder: (_, index) => const Divider(
                  height: 0.8,
                  indent: 88,
                  endIndent: 16.0,
                ),
              ),

              /// Ничего не найдено.
              empty: () => EmptyList(
                icon: AppIcons.searchBig,
                title: AppStrings.nothingFound,
                details: AppStrings.tryAnotherSearch,
                padding: shift(),
              ),

              /// Ошибка поиска.
              error: (error, _) => EmptyList(
                icon: AppIcons.error,
                title: AppStrings.error,
                details: error,
                padding: shift(),
              ),
            );
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
      _store.dispatch(const SearchState.initial());
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
    final pattern = _controller.text;

    // Так как поиск начинаем с задержкой, поле ввода могли очистить,
    // в этом случае отображаем историю
    _store.dispatch(pattern.isEmpty
        ? const SearchState.initial()
        : SearchAction.start(pattern));
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
        url: sight.urls.first,
        size: const Size.square(56.0),
        borderRadius: 12.0,
      ),
      title: Text(sight.name, style: theme.textOnBackground),
      subtitle: Text(sight.type.title, style: theme.smallSecondary2),
      onTap: () => _showDetails(context),
    );
  }

  /// Показ экрана детализации.
  void _showDetails(BuildContext context) {
    context.pushBottomSheet(AppRoutes.details, args: sight.id);
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
