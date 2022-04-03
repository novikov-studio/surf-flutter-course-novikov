import 'package:places/service/location.dart';

/// Интерфейс для получения текущих координат.
abstract class LocationRepository {
  //static LocationRepository getInstance() => MockLocationRepository();

  Future<Location> current();
}
