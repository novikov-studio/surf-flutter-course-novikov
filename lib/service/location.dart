// todo: Удалть
class Location {
  final double latitude; // Широта, в градусах
  final double longitude; // Долгота, в градусах

  const Location({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => '(lat: $latitude, lon: $longitude)';
}
