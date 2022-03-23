import 'package:flutter/foundation.dart';

/// Класс для хранения настроек фильтра.
@immutable
class Filter {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10.0; // км

  // Список категорий
  final Set<String>? categories;

  // Минимальный радиус поиска
  final double? minRadius;

  // Максимальный радиус поиска
  final double? maxRadius;

  // Фильтр по имени
  final String? pattern;

  bool get isEmpty =>
      categories == null && maxRadius == null && pattern == null;

  @override
  int get hashCode => Object.hashAll([
        if (categories != null) Object.hashAllUnordered(categories!) else null,
        minRadius,
        maxRadius,
        pattern,
      ]);

  const Filter({
    this.categories,
    this.minRadius,
    this.maxRadius,
    this.pattern,
  }) : assert(minRadius == null || maxRadius != null);

  @override
  String toString() => 'Filter('
      'categories: ${categories?.length}, '
      'minRadius: $minRadius, '
      'maxRadius: $maxRadius, '
      'pattern: $pattern)';

  @override
  bool operator ==(Object other) {
    return other is Filter &&
        setEquals(categories, other.categories) &&
        minRadius == other.minRadius &&
        maxRadius == other.maxRadius &&
        pattern == other.pattern;
  }

  Filter copyWith({
    Set<String>? categories,
    double? minRadius,
    double? maxRadius,
    String? pattern,
  }) =>
      Filter(
        minRadius: minRadius ?? this.minRadius,
        maxRadius: maxRadius ?? this.maxRadius,
        categories: categories ?? this.categories,
        pattern: pattern ?? this.pattern,
      );
}
