import 'package:places/ui/const/errors.dart';
import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:places/ui/redux/state/search_state.dart';

/// Редьюсер начала поиска.
AppState startSearchReducer(AppState state, StartSearchAction _) =>
    state.copyWith(searchState: const SearchState.loading());

/// Редьюсер результата поиска.
AppState resultSearchReducer(AppState state, ResultSearchAction action) =>
    state.copyWith(
      searchState: action.sights.isEmpty
          ? const SearchState.empty()
          : SearchState.found(action.sights),
    );

/// Редьюсер ошибки поиска.
AppState errorSearchReducer(AppState state, ErrorSearchAction action) =>
    state.copyWith(
      searchState: SearchState.error(
        message: Errors.humanReadableText(action.error),
        critical: Errors.isCritical(action.error),
      ),
    );
