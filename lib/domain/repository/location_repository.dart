import 'package:places/data/repository/mock_location_repository.dart';
import 'package:places/domain/entity/location.dart';

/// Интерфейс для получения текущих координат.
abstract class LocationRepository {
  const factory LocationRepository.getInstance() = MockLocationRepository;

  Future<Location> current();
}
