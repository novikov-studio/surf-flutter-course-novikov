import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/domain/location.dart';

class MockLocationRepository implements LocationRepository {
  const MockLocationRepository();

  @override
  Future<Location> current() async =>
      const Location(latitude: 47.516898, longitude: 42.146062);
}
