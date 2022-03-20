import 'package:flutter/foundation.dart';
import 'package:places/service/location.dart';

/// Класс для хранения настроек фильтра.
@immutable
class Filter {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10.0; // км

  // Список категорий
  final Set<String>? categories;

  // Текущие координаты
  final Location? location;

  // Минимальный радиус поиска
  final double? minRadius;

  // Максимальный радиус поиска
  final double? maxRadius;

  // Фильтр по имени
  final String? pattern;

  bool get isEmpty =>
      categories == null && maxRadius == null && pattern == null;

  const Filter({
    this.categories,
    this.location,
    this.minRadius,
    this.maxRadius,
    this.pattern,
  })  : assert(location == null && maxRadius == null ||
            location != null && maxRadius != null),
        assert(minRadius == null || location != null && maxRadius != null);

  @override
  String toString() => 'Filter('
      'categories: ${categories?.length}, '
      'location: $location, '
      'minRadius: $minRadius, '
      'maxRadius: $maxRadius, '
      'pattern: $pattern)';

  Filter copyWith({
    Set<String>? categories,
    Location? location,
    double? minRadius,
    double? maxRadius,
    String? pattern,
  }) =>
      Filter(
        location: location ?? this.location,
        minRadius: minRadius ?? this.minRadius,
        maxRadius: maxRadius ?? this.maxRadius,
        categories: categories ?? this.categories,
        pattern: pattern ?? this.pattern,
      );
}
