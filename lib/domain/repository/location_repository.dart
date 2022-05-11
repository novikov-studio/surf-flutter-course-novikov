import 'package:places/domain/entity/location.dart';

/// Интерфейс для получения текущих координат.
// ignore: one_member_abstracts
abstract class LocationRepository {
  Future<Location?> current();
}
