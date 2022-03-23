import 'package:places/service/location.dart';

/// Модель достопримечательности.
class Sight {
  final String id; // уникальный идентификатор
  final String name; // название
  final Location location; // координаты
  final List<String> urls; // ссылки на фотографии
  final String? info; // краткое описание
  final String? details; // полное описание
  final String type; // категория объекта
  final DateTime? plannedDate; // дата запланированного посещения
  final DateTime? visitedDate; // дата достижения цели
  final bool isLiked; // добавлено ли в Избранное

  /// Краткое описание.
  String? get brief => info ?? details;

  /// Запланировано ли посещение.
  bool get isPlanned => plannedDate != null && visitedDate == null;

  /// Достигнута ли цель.
  bool get isVisited => visitedDate != null;

  const Sight({
    required this.id,
    required this.name,
    required this.location,
    required this.urls,
    this.info,
    this.details,
    required this.type,
    this.plannedDate,
    this.visitedDate,
    this.isLiked = false,
  });

  /// Соответствие поисковому запросу.
  bool isMatch(String text) {
    final lowerText = text.toLowerCase();

    return name.toLowerCase().contains(lowerText) ||
        type.toLowerCase().contains(lowerText);
  }

  /// Клонирование объекта.
  Sight copyWith({
    String? id,
    DateTime? plannedDate,
    DateTime? visitedDate,
    bool? isLiked,
  }) {
    final sight = Sight(
      id: id ?? this.id,
      name: name,
      location: location,
      urls: urls,
      info: info,
      details: details,
      type: type,
      plannedDate: isLiked == false ? null : (plannedDate ?? this.plannedDate),
      visitedDate: isLiked == false ? null : (visitedDate ?? this.visitedDate),
      isLiked: isLiked ?? this.isLiked,
    );
    // Проверяем, что при удалении из Избранного сбрасываются даты
    assert(this.isLiked || plannedDate == null && visitedDate == null);

    return sight;
  }
}
