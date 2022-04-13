// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

  _Filter call(
      {Set<Category>? categories,
      double? minRadius,
      double? maxRadius,
      String? pattern}) {
    return _Filter(
      categories: categories,
      minRadius: minRadius,
      maxRadius: maxRadius,
      pattern: pattern,
    );
  }
}

/// @nodoc
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
// Список категорий
  Set<Category>? get categories =>
      throw _privateConstructorUsedError; // Минимальный радиус поиска
  double? get minRadius =>
      throw _privateConstructorUsedError; // Максимальный радиус поиска
  double? get maxRadius =>
      throw _privateConstructorUsedError; // Фильтр по имени
  String? get pattern => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
  $Res call(
      {Set<Category>? categories,
      double? minRadius,
      double? maxRadius,
      String? pattern});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;

  @override
  $Res call({
    Object? categories = freezed,
    Object? minRadius = freezed,
    Object? maxRadius = freezed,
    Object? pattern = freezed,
  }) {
    return _then(_value.copyWith(
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<Category>?,
      minRadius: minRadius == freezed
          ? _value.minRadius
          : minRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      maxRadius: maxRadius == freezed
          ? _value.maxRadius
          : maxRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      pattern: pattern == freezed
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$FilterCopyWith(_Filter value, $Res Function(_Filter) then) =
      __$FilterCopyWithImpl<$Res>;
  @override
  $Res call(
      {Set<Category>? categories,
      double? minRadius,
      double? maxRadius,
      String? pattern});
}

/// @nodoc
class __$FilterCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements _$FilterCopyWith<$Res> {
  __$FilterCopyWithImpl(_Filter _value, $Res Function(_Filter) _then)
      : super(_value, (v) => _then(v as _Filter));

  @override
  _Filter get _value => super._value as _Filter;

  @override
  $Res call({
    Object? categories = freezed,
    Object? minRadius = freezed,
    Object? maxRadius = freezed,
    Object? pattern = freezed,
  }) {
    return _then(_Filter(
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<Category>?,
      minRadius: minRadius == freezed
          ? _value.minRadius
          : minRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      maxRadius: maxRadius == freezed
          ? _value.maxRadius
          : maxRadius // ignore: cast_nullable_to_non_nullable
              as double?,
      pattern: pattern == freezed
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Filter extends _Filter {
  const _$_Filter(
      {this.categories, this.minRadius, this.maxRadius, this.pattern})
      : assert(minRadius == null || maxRadius != null),
        super._();

  @override // Список категорий
  final Set<Category>? categories;
  @override // Минимальный радиус поиска
  final double? minRadius;
  @override // Максимальный радиус поиска
  final double? maxRadius;
  @override // Фильтр по имени
  final String? pattern;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Filter &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality().equals(other.minRadius, minRadius) &&
            const DeepCollectionEquality().equals(other.maxRadius, maxRadius) &&
            const DeepCollectionEquality().equals(other.pattern, pattern));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(minRadius),
      const DeepCollectionEquality().hash(maxRadius),
      const DeepCollectionEquality().hash(pattern));

  @JsonKey(ignore: true)
  @override
  _$FilterCopyWith<_Filter> get copyWith =>
      __$FilterCopyWithImpl<_Filter>(this, _$identity);
}

abstract class _Filter extends Filter {
  const factory _Filter(
      {Set<Category>? categories,
      double? minRadius,
      double? maxRadius,
      String? pattern}) = _$_Filter;
  const _Filter._() : super._();

  @override // Список категорий
  Set<Category>? get categories;
  @override // Минимальный радиус поиска
  double? get minRadius;
  @override // Максимальный радиус поиска
  double? get maxRadius;
  @override // Фильтр по имени
  String? get pattern;
  @override
  @JsonKey(ignore: true)
  _$FilterCopyWith<_Filter> get copyWith => throw _privateConstructorUsedError;
}
