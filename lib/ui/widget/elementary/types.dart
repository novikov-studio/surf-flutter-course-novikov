import 'package:elementary/elementary.dart';

typedef ListenableEntityState<T> = ListenableState<EntityState<T>>;

// ignore: prefer-match-file-name
extension ListenableStateExtension<T> on ListenableState<T> {
  bool equals(T? other) => value == other;
}
