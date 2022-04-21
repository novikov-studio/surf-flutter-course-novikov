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
import 'package:rxdart/rxdart.dart';

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
  final _controller = TextEditingController();
  final _debounce = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    _debounce.stream
        .debounce(
          (value) => TimerStream<String>(
            value,
            Duration(
              milliseconds:
                  value.trim().isEmpty || value.endsWith(' ') ? 0 : 500,
            ),
          ),
        )
        .map((value) => value.trim())
        .distinct()
        .where((value) => value.isEmpty || value.length > 2)
        .listen(_search);
    _controller.addListener(_onTextChanged);
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
                itemBuilder: (_, index) => _SightListTile(sight: sights[index]),
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
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    _debounce.close();
    super.dispose();
  }

  /// Поиск мест по подстроке.
  void _search(String text) {
    _store.dispatch(
      text.isNotEmpty ? SearchAction.start(text) : const SearchState.initial(),
    );
  }

  /// Callback на изменения текста в поле ввода.
  void _onTextChanged() {
    _debounce.add(_controller.text);
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
        url: sight.urls.isNotEmpty ? sight.urls.first : '',
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
