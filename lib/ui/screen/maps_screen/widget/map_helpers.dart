import 'package:latlong2/latlong.dart';
import 'package:places/domain/entity/location.dart';

abstract class MapHelpers {
  static const lightModeUrl =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png';
  static const darkModeUrl =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
}

/// Расширение для LatLng.
extension LatLngExt on LatLng {
  Location get asLocation => Location(
    latitude: latitude,
    longitude: longitude,
  );
}

/// Расширение для Location.
extension LocationExt on Location {
  LatLng get asLatLng {
    // Workaround: на сервере есть места с некорректными координатами
    final lat = latitude < -90.0 ? -90.0 : (latitude > 90.0 ? 90.0 : latitude);
    final lng =
    longitude < -180.0 ? -180.0 : (longitude > 180.0 ? 180.0 : longitude);

    return LatLng(lat, lng);
  }
}
