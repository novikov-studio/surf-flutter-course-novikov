import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/const/app_routes.dart';
import 'package:places/ui/screen/res/app_scope.dart';
import 'package:places/ui/screen/res/logger.dart';
import 'package:places/ui/screen/res/scaffold_messenger_extension.dart';
import 'package:places/ui/screen/res/theme_extension.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen_model.dart';
import 'package:places/ui/widget/elementary/common_wm_mixin.dart';
import 'package:places/ui/widget/elementary/state_notifier_builder_ex.dart';
import 'package:places/ui/widget/elementary/types.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// WM для экрана "Поиск мест".
class SightSearchScreenWM
    extends WidgetModel<SightSearchScreen, SightSearchScreenModel>
    with CommonWMMixin<SightSearchScreen, SightSearchScreenModel>
    implements ISightSearchScreenWidgetModel {
  final _searchState = EntityStateNotifier<List<Sight>>();
  final _historyState = EntityStateNotifier<List<String>>();
  final _debounce = PublishSubject<String>();
  final _textController = TextEditingController();

  @override
  ListenableEntityState<List<Sight>> get searchState => _searchState;

  @override
  ListenableEntityState<List<String>> get historyState => _historyState;

  @override
  TextEditingController get textController => _textController;

  SightSearchScreenWM(SightSearchScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
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

    _textController.addListener(_onTextChanged);
    _historyState.addListener(_onHistoryStateChange);
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);
    logError(error);
    ScaffoldMessenger.of(context).showObjError(error);
  }

  @override
  void dispose() {
    _debounce.close();
    _textController
      ..removeListener(_onTextChanged)
      ..dispose();
    _historyState.removeListener(_onHistoryStateChange);
    super.dispose();
  }

  @override
  void showDetails(int sightId) {
    context.pushBottomSheet(AppRoutes.details, args: sightId);
  }

  @override
  Future<void> removeFromHistory(String value) async {
    try {
      await model.removeFromHistory(value);
    } on Object catch (e) {
      onErrorHandle(e);
    } finally {
      await _loadHistory();
    }
  }

  @override
  Future<void> clearHistory() async {
    try {
      await model.clearHistory();
      _historyState.initial();
    } on Object catch (e) {
      onErrorHandle(e);
      await _loadHistory();
    }
  }

  @override
  void searchFromHistory(String text) {
    _textController
      ..text = text
      ..selection = TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      );
  }

  /// Callback на изменения текста в поле ввода.
  void _onTextChanged() {
    _debounce.add(_textController.text);
  }

  /// Поиск мест по подстроке.
  Future<void> _search(String text) async {
    if (text.isEmpty) {
      _searchState.initial();

      return;
    }

    _searchState.loading();
    try {
      final sights = await model.search(text);
      // Если за время поиска успели очистить поле ввода,
      // значит результат уже не интересен, отображаем историю
      _textController.text.isEmpty
          ? _searchState.initial()
          : _searchState.content(sights);
    } on Exception catch (e) {
      _searchState.error(e);
    }
  }

  /// Загрузка истории поиска.
  Future<void> _loadHistory({bool silent = true}) async {
    if (!silent) {
      _historyState.loading();
    }

    try {
      final items = await model.loadHistory();
      _historyState.content(items);
    } on Object catch (e) {
      onErrorHandle(e);
      _historyState.initial();
    }
  }

  /// Обработчик изменения состояния истории.
  void _onHistoryStateChange() {
    if (_historyState.value?.isInitial ?? true) {
      _loadHistory(silent: false);
    }
  }
}

/// Интерфейс WM.
abstract class ISightSearchScreenWidgetModel extends ICommonWidgetModel {
  /// Состояние поиска.
  ListenableEntityState<List<Sight>> get searchState;

  /// Состояние истории поиска.
  ListenableEntityState<List<String>> get historyState;

  /// Контроллер текстового поля поиска
  TextEditingController get textController;

  /// Показ экрана детализации.
  void showDetails(int sightId);

  /// Удаление элемента из ситории поиска.
  Future<void> removeFromHistory(String value);

  /// Очистка истории поиска.
  Future<void> clearHistory();

  /// Повторный поиск из истории поиска.
  void searchFromHistory(String text);
}

/// Реализация WM по-умолчанию.
SightSearchScreenWM defaultSightSearchScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = SightSearchScreenModel(
    appDependencies.errorHandler,
    appDependencies.searchInteractor,
  );

  return SightSearchScreenWM(model);
}
