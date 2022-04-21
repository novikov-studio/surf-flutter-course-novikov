import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/sight.dart';

part 'search_state.freezed.dart';

/// Состояние поиска достопримечательностей.
@freezed
class SearchState with _$SearchState {
  const SearchState._();

  /// Начальное состояние.
  const factory SearchState.initial() = InitialSearchState;

  /// Идет поиск.
  const factory SearchState.loading() = LoadingSearchState;

  /// Результат.
  const factory SearchState.found(List<Sight> sights) = FoundSearchState;

  /// Ничего не найдено.
  const factory SearchState.empty() = EmptySearchState;

  /// Ошибка поиска.
  const factory SearchState.error({
    required String message,
    required bool critical,
  }) = ErrorSearchState;
}
