import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/sight.dart';

part 'search_action.freezed.dart';

/// Действия для поиска достопримечательностей.
@freezed
class SearchAction with _$SearchAction {
  const SearchAction._();

  /// Начать поиск.
  const factory SearchAction.start(String pattern) = StartSearchAction;

  /// Результат поиска.
  const factory SearchAction.result(List<Sight> sights) = ResultSearchAction;

  /// Результат поиска.
  const factory SearchAction.error(Object error) = ErrorSearchAction;
}
