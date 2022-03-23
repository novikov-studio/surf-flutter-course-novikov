import 'package:places/data/mock_sight_repository.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location_provider.dart';
import 'package:places/domain/sight.dart';

/// Интерфейс репозитория интересных мест.
abstract class SightRepository {
  static SightRepository createRepository({
    required LocationProvider locationProvider,
  }) =>
      MockSightRepository(locationProvider);

  Future<Iterable<Sight>> items({Filter? filter});

  Future<Sight> create(Sight value);

  Future<Sight> read(String id);

  Future<void> update(Sight value);

  Future<void> delete(String id);
}