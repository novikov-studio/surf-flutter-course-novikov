import 'package:geolocator/geolocator.dart';
import 'package:places/domain/entity/location.dart';
import 'package:places/domain/repository/location_repository.dart';

/// Репозитрий для получения текущего местоположения.
///
/// Поиск местоположения осуществляется в течение 45 секунд.
/// Последние полученные координаты кэшируются на 15 секунд.
class GeoLocationRepository implements LocationRepository {
  final _cache = _LocationCache(timeoutInSec: 15);

  GeoLocationRepository();

  @override
  Future<Location?> current() async {
    try {
      var location = _cache.location;

      if (location == null) {
        final position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 45),
        );

        location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        _cache.location = location;
      }

      return location;
    } on Object {
      return null;
    }
  }
}

/// Кэширование координат на указанный таймаут.
class _LocationCache {
  final int _timeout;

  Location? get location => _elapsed ? null : _location;

  set location(Location? value) {
    _location = value;
    _lastRequestTime = DateTime.now();
  }

  DateTime? _lastRequestTime;
  Location? _location;

  bool get _elapsed =>
      _lastRequestTime == null ||
      DateTime.now().difference(_lastRequestTime!).inSeconds > _timeout;

  _LocationCache({required int timeoutInSec}) : _timeout = timeoutInSec;
}
