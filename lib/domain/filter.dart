import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/sight.dart';

part 'filter.freezed.dart';

/// Класс для хранения настроек фильтра.
@freezed
class Filter with _$Filter {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10.0; // км

  bool get isEmpty =>
      categories == null && maxRadius == null && pattern == null;

  @Assert('minRadius == null || maxRadius != null')
  const factory Filter({
    // Список категорий
    Set<Category>? categories,
    // Минимальный радиус поиска
    double? minRadius,
    // Максимальный радиус поиска
    double? maxRadius,
    // todo: убрать pattern
    // Фильтр по имени
    String? pattern,
  }) = _Filter;

  const Filter._();

  @override
  String toString() => 'Filter('
      'categories: ${categories?.length}, '
      'minRadius: $minRadius, '
      'maxRadius: $maxRadius, '
      'pattern: $pattern)';
}
