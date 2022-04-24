import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/ui/redux/state/search_state.dart';

part '../../../gen/ui/redux/state/app_state.freezed.dart';

/// Общее состояние приложения.
@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(SearchState.initial()) SearchState searchState,
  }) = _AppState;
}
