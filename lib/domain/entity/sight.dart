import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:places/domain/entity/location.dart';

part '../../gen/domain/entity/sight.freezed.dart';

typedef SightList = Iterable<Sight>;

/// Модель достопримечательности.
@freezed
class Sight with _$Sight {
  /// Краткое описание.
  String? get brief => info ?? details;

  /// Запланировано ли посещение.
  bool get isPlanned => plannedDate != null && visitedDate == null;

  /// Достигнута ли цель.
  bool get isVisited => visitedDate != null;

  const factory Sight({
    /// Уникальный идентификатор.
    required int id,

    /// Название.
    required String name,

    /// Координаты.
    required Location location,

    /// Ссылки на фотографии.
    required List<String> urls,

    /// Краткое описание.
    String? info,

    /// Полное описание.
    String? details,

    /// Категория объекта.
    required Category type,

    /// Дата запланированного посещения.
    DateTime? plannedDate,

    /// Дата достижения цели.
    DateTime? visitedDate,

    /// Добавлено ли в Избранное.
    @Default(false) bool isLiked,
  }) = _Sight;

  const Sight._();

  /// Соответствие поисковому запросу.
  bool isMatch(String text) {
    final lowerText = text.toLowerCase();

    return name.toLowerCase().contains(lowerText);
  }
}

enum Category { hotel, restaurant, particularPlace, park, museum, cafe }
