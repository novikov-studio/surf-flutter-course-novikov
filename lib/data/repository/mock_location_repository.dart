import 'package:places/domain/entity/location.dart';
import 'package:places/domain/repository/location_repository.dart';

class MockLocationRepository implements LocationRepository {
  const MockLocationRepository();

  @override
  Future<Location> current() async {
    await Future<void>.delayed(const Duration(milliseconds: 2000));

    return const Location(latitude: 47.516898, longitude: 42.146062);
  }
}
