/// Модель достопримечательности
class Sight {
  final String name; // название
  final double lat; // широта
  final double lon; // долгота
  final String url; // ссылка на фотографию
  final String? info; // краткое описание
  final String? details; // полное описание
  final String type; // тип

  String? get brief => info ?? details;

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    this.info,
    this.details,
    required this.type,
  });
}
