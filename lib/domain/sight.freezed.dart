// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SightTearOff {
  const _$SightTearOff();

  _Sight call(
      {required int id,
      required String name,
      required Location location,
      required List<String> urls,
      String? info,
      String? details,
      required Category type,
      DateTime? plannedDate,
      DateTime? visitedDate,
      bool isLiked = false}) {
    return _Sight(
      id: id,
      name: name,
      location: location,
      urls: urls,
      info: info,
      details: details,
      type: type,
      plannedDate: plannedDate,
      visitedDate: visitedDate,
      isLiked: isLiked,
    );
  }
}

/// @nodoc
const $Sight = _$SightTearOff();

/// @nodoc
mixin _$Sight {
  /// Уникальный идентификатор.
  int get id => throw _privateConstructorUsedError;

  /// Название.
  String get name => throw _privateConstructorUsedError;

  /// Координаты.
  Location get location => throw _privateConstructorUsedError;

  /// Ссылки на фотографии.
  List<String> get urls => throw _privateConstructorUsedError;

  /// Краткое описание.
  String? get info => throw _privateConstructorUsedError;

  /// Полное описание.
  String? get details => throw _privateConstructorUsedError;

  /// Категория объекта.
  Category get type => throw _privateConstructorUsedError;

  /// Дата запланированного посещения.
  DateTime? get plannedDate => throw _privateConstructorUsedError;

  /// Дата достижения цели.
  DateTime? get visitedDate => throw _privateConstructorUsedError;

  /// Добавлено ли в Избранное.
  bool get isLiked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SightCopyWith<Sight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SightCopyWith<$Res> {
  factory $SightCopyWith(Sight value, $Res Function(Sight) then) =
      _$SightCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      Location location,
      List<String> urls,
      String? info,
      String? details,
      Category type,
      DateTime? plannedDate,
      DateTime? visitedDate,
      bool isLiked});
}

/// @nodoc
class _$SightCopyWithImpl<$Res> implements $SightCopyWith<$Res> {
  _$SightCopyWithImpl(this._value, this._then);

  final Sight _value;
  // ignore: unused_field
  final $Res Function(Sight) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? location = freezed,
    Object? urls = freezed,
    Object? info = freezed,
    Object? details = freezed,
    Object? type = freezed,
    Object? plannedDate = freezed,
    Object? visitedDate = freezed,
    Object? isLiked = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Category,
      plannedDate: plannedDate == freezed
          ? _value.plannedDate
          : plannedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitedDate: visitedDate == freezed
          ? _value.visitedDate
          : visitedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$SightCopyWith<$Res> implements $SightCopyWith<$Res> {
  factory _$SightCopyWith(_Sight value, $Res Function(_Sight) then) =
      __$SightCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      Location location,
      List<String> urls,
      String? info,
      String? details,
      Category type,
      DateTime? plannedDate,
      DateTime? visitedDate,
      bool isLiked});
}

/// @nodoc
class __$SightCopyWithImpl<$Res> extends _$SightCopyWithImpl<$Res>
    implements _$SightCopyWith<$Res> {
  __$SightCopyWithImpl(_Sight _value, $Res Function(_Sight) _then)
      : super(_value, (v) => _then(v as _Sight));

  @override
  _Sight get _value => super._value as _Sight;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? location = freezed,
    Object? urls = freezed,
    Object? info = freezed,
    Object? details = freezed,
    Object? type = freezed,
    Object? plannedDate = freezed,
    Object? visitedDate = freezed,
    Object? isLiked = freezed,
  }) {
    return _then(_Sight(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      urls: urls == freezed
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Category,
      plannedDate: plannedDate == freezed
          ? _value.plannedDate
          : plannedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      visitedDate: visitedDate == freezed
          ? _value.visitedDate
          : visitedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Sight extends _Sight {
  const _$_Sight(
      {required this.id,
      required this.name,
      required this.location,
      required this.urls,
      this.info,
      this.details,
      required this.type,
      this.plannedDate,
      this.visitedDate,
      this.isLiked = false})
      : super._();

  @override

  /// Уникальный идентификатор.
  final int id;
  @override

  /// Название.
  final String name;
  @override

  /// Координаты.
  final Location location;
  @override

  /// Ссылки на фотографии.
  final List<String> urls;
  @override

  /// Краткое описание.
  final String? info;
  @override

  /// Полное описание.
  final String? details;
  @override

  /// Категория объекта.
  final Category type;
  @override

  /// Дата запланированного посещения.
  final DateTime? plannedDate;
  @override

  /// Дата достижения цели.
  final DateTime? visitedDate;
  @JsonKey()
  @override

  /// Добавлено ли в Избранное.
  final bool isLiked;

  @override
  String toString() {
    return 'Sight(id: $id, name: $name, location: $location, urls: $urls, info: $info, details: $details, type: $type, plannedDate: $plannedDate, visitedDate: $visitedDate, isLiked: $isLiked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Sight &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.urls, urls) &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality().equals(other.details, details) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.plannedDate, plannedDate) &&
            const DeepCollectionEquality()
                .equals(other.visitedDate, visitedDate) &&
            const DeepCollectionEquality().equals(other.isLiked, isLiked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(urls),
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(details),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(plannedDate),
      const DeepCollectionEquality().hash(visitedDate),
      const DeepCollectionEquality().hash(isLiked));

  @JsonKey(ignore: true)
  @override
  _$SightCopyWith<_Sight> get copyWith =>
      __$SightCopyWithImpl<_Sight>(this, _$identity);
}

abstract class _Sight extends Sight {
  const factory _Sight(
      {required int id,
      required String name,
      required Location location,
      required List<String> urls,
      String? info,
      String? details,
      required Category type,
      DateTime? plannedDate,
      DateTime? visitedDate,
      bool isLiked}) = _$_Sight;
  const _Sight._() : super._();

  @override

  /// Уникальный идентификатор.
  int get id;
  @override

  /// Название.
  String get name;
  @override

  /// Координаты.
  Location get location;
  @override

  /// Ссылки на фотографии.
  List<String> get urls;
  @override

  /// Краткое описание.
  String? get info;
  @override

  /// Полное описание.
  String? get details;
  @override

  /// Категория объекта.
  Category get type;
  @override

  /// Дата запланированного посещения.
  DateTime? get plannedDate;
  @override

  /// Дата достижения цели.
  DateTime? get visitedDate;
  @override

  /// Добавлено ли в Избранное.
  bool get isLiked;
  @override
  @JsonKey(ignore: true)
  _$SightCopyWith<_Sight> get copyWith => throw _privateConstructorUsedError;
}
