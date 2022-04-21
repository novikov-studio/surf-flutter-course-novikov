import 'package:places/ui/redux/action/search_action.dart';
import 'package:places/ui/redux/reducer/search_reducer.dart';
import 'package:places/ui/redux/state/app_state.dart';
import 'package:redux/redux.dart';

/// Основной редьюсер.
final reducer = combineReducers<AppState>([
  TypedReducer<AppState, StartSearchAction>(startSearchReducer),
  TypedReducer<AppState, ResultSearchAction>(resultSearchReducer),
  TypedReducer<AppState, ErrorSearchAction>(errorSearchReducer),
]);
