import 'package:places/data/mock_location_provider.dart';
import 'package:places/service/location.dart';

/// Интерфейс для получения текущих координат.
abstract class LocationProvider {
  static LocationProvider createProvider() => MockLocationProvider();

  Future<Location> current();
}
