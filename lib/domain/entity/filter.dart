import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/entity/sight.dart';

part '../../gen/domain/entity/filter.freezed.dart';

part '../../gen/domain/entity/filter.g.dart';

/// Класс для хранения настроек фильтра.
@freezed
class Filter with _$Filter {
  static const double minDistance = 0.1; // км
  static const double maxDistance = 10.0; // км

  bool get isEmpty =>
      categories == null && maxRadius == null;

  @Assert('minRadius == null || maxRadius != null')
  const factory Filter({
    // Список категорий
    Set<Category>? categories,
    // Минимальный радиус поиска
    double? minRadius,
    // Максимальный радиус поиска
    double? maxRadius,
  }) = _Filter;

  const Filter._();

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  @override
  String toString() => 'Filter('
      'categories: ${categories?.length}, '
      'minRadius: $minRadius, '
      'maxRadius: $maxRadius)';
}
