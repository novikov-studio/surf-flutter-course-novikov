import 'package:places/data/repository_interface/location_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/service/location.dart';

class MockLocationRepository implements LocationRepository {
  const MockLocationRepository();

  @override
  Future<Location> current() async => mockCurrentLocation;
}
