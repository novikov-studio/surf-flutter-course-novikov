// ignore_for_file: avoid_annotating_with_dynamic

typedef FromJson<T> = T Function(Map<String, dynamic> json);

/// Вспомогательный класс для десериализации объектов из JSON.
abstract class RestDeserializer {
  /// Десериализация одного объекта.
  static T map<T>(
    dynamic value,
    FromJson<T> fromJson,
  ) {
    assert(value is Map<String, dynamic>);

    return fromJson(value as Map<String, dynamic>);
  }

  /// Десериализация списка объектов.
  static Iterable<T> list<T>(
    dynamic value,
    FromJson<T> fromJson,
  ) {
    assert(value is List<dynamic>);

    return (value as List)
        .map((dynamic e) => fromJson(e as Map<String, dynamic>));
  }
}
