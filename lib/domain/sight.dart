/// Модель достопримечательности
class Sight {
  final String name; // название
  final double lat; // широта
  final double lon; // долгота
  final String url; // ссылка на фотографию
  final String? info; // краткое описание
  final String? details; // полное описание
  final String type; // тип
  final DateTime? planned; // дата запланированного посещения
  final bool liked; // добавлено ли в Избранное

  String? get brief => info ?? details;

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    this.info,
    this.details,
    required this.type,
    this.planned,
    this.liked = false,
  });
}
