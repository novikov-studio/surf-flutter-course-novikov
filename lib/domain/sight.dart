import 'package:places/service/location.dart';

/// Модель достопримечательности.
class Sight {
  final String name; // название
  final Location location; // координаты
  final String url; // ссылка на фотографию
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
    required this.name,
    required this.location,
    required this.url,
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
}
