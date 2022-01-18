/// Модель достопримечательности
class Sight {
  final String name; // название
  final double lat; // широта
  final double lon; // долгота
  final String url; // ссылка на фотографию
  final String details; // описание
  final String type; // тип

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
  });
}
