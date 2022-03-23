import 'package:places/domain/location_provider.dart';
import 'package:places/mocks.dart';
import 'package:places/service/location.dart';

class MockLocationProvider implements LocationProvider {
  @override
  Future<Location> current() async => mockCurrentLocation;
}
