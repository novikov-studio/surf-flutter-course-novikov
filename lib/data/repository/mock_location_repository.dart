import 'package:places/domain/entity/location.dart';
import 'package:places/domain/repository/location_repository.dart';

class MockLocationRepository implements LocationRepository {
  const MockLocationRepository();

  @override
  Future<Location> current() async =>
      const Location(latitude: 47.516898, longitude: 42.146062);
}
