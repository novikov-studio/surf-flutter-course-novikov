import 'package:places/domain/filter.dart';
import 'package:places/domain/location_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/service/utils.dart';

class MockSightRepository implements SightRepository {
  final LocationProvider _locationProvider;
  int _generatorId = 10000;

  MockSightRepository(this._locationProvider);

  @override
  Future<Sight> create(Sight value) async {
    if (mocks.any((element) => element.id == value.id)) {
      throw Exception('duplicate id');
    }

    final item = value.copyWith(id: _generatorId++);
    mocks.add(item);

    return item;
  }

  @override
  Future<void> delete(int id) async {
    mocks.removeWhere((element) => element.id == id);
  }

  @override
  Future<Iterable<Sight>> items({Filter? filter}) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (filter == null || filter.isEmpty) {
      return List.unmodifiable(mocks);
    }

    final result = List<Sight>.from(mocks);

    // Фильтр по категории
    if (filter.categories != null) {
      result.retainWhere(
        (element) => filter.categories!.contains(element.type),
      );
    }

    // Фильтр по названию
    if (filter.pattern != null) {
      result.retainWhere(
        (element) => element.isMatch(filter.pattern!),
      );
    }

    // Фильтр по расстоянию
    if (filter.maxRadius != null) {
      final location = await _locationProvider.current();
      result.retainWhere(
        (sight) => Utils.isPointInRingArea(
          point: sight.location,
          center: location,
          minRadius: filter.minRadius,
          maxRadius: filter.maxRadius!,
        ),
      );
    }

    return List.unmodifiable(result);
  }

  @override
  Future<Sight> read(int id) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return mocks.firstWhere((element) => element.id == id);
  }

  @override
  Future<void> update(Sight value) async {
    final index = mocks.indexWhere((element) => element.id == value.id);
    if (index >= 0) {
      mocks.replaceRange(index, index+1, [value]);
    } else {
      throw Exception('not found');
    }
  }
}
