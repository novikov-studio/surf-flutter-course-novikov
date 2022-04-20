// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pattern) start,
    required TResult Function(List<Sight> sights) result,
    required TResult Function(Object error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartSearchAction value) start,
    required TResult Function(ResultSearchAction value) result,
    required TResult Function(ErrorSearchAction value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchActionCopyWith<$Res> {
  factory $SearchActionCopyWith(
          SearchAction value, $Res Function(SearchAction) then) =
      _$SearchActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchActionCopyWithImpl<$Res> implements $SearchActionCopyWith<$Res> {
  _$SearchActionCopyWithImpl(this._value, this._then);

  final SearchAction _value;
  // ignore: unused_field
  final $Res Function(SearchAction) _then;
}

/// @nodoc
abstract class $StartSearchActionCopyWith<$Res> {
  factory $StartSearchActionCopyWith(
          StartSearchAction value, $Res Function(StartSearchAction) then) =
      _$StartSearchActionCopyWithImpl<$Res>;
  $Res call({String pattern});
}

/// @nodoc
class _$StartSearchActionCopyWithImpl<$Res>
    extends _$SearchActionCopyWithImpl<$Res>
    implements $StartSearchActionCopyWith<$Res> {
  _$StartSearchActionCopyWithImpl(
      StartSearchAction _value, $Res Function(StartSearchAction) _then)
      : super(_value, (v) => _then(v as StartSearchAction));

  @override
  StartSearchAction get _value => super._value as StartSearchAction;

  @override
  $Res call({
    Object? pattern = freezed,
  }) {
    return _then(StartSearchAction(
      pattern == freezed
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StartSearchAction extends StartSearchAction {
  const _$StartSearchAction(this.pattern) : super._();

  @override
  final String pattern;

  @override
  String toString() {
    return 'SearchAction.start(pattern: $pattern)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StartSearchAction &&
            const DeepCollectionEquality().equals(other.pattern, pattern));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pattern));

  @JsonKey(ignore: true)
  @override
  $StartSearchActionCopyWith<StartSearchAction> get copyWith =>
      _$StartSearchActionCopyWithImpl<StartSearchAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pattern) start,
    required TResult Function(List<Sight> sights) result,
    required TResult Function(Object error) error,
  }) {
    return start(pattern);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
  }) {
    return start?.call(pattern);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(pattern);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartSearchAction value) start,
    required TResult Function(ResultSearchAction value) result,
    required TResult Function(ErrorSearchAction value) error,
  }) {
    return start(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
  }) {
    return start?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
    required TResult orElse(),
  }) {
    if (start != null) {
      return start(this);
    }
    return orElse();
  }
}

abstract class StartSearchAction extends SearchAction {
  const factory StartSearchAction(final String pattern) = _$StartSearchAction;
  const StartSearchAction._() : super._();

  String get pattern => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StartSearchActionCopyWith<StartSearchAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultSearchActionCopyWith<$Res> {
  factory $ResultSearchActionCopyWith(
          ResultSearchAction value, $Res Function(ResultSearchAction) then) =
      _$ResultSearchActionCopyWithImpl<$Res>;
  $Res call({List<Sight> sights});
}

/// @nodoc
class _$ResultSearchActionCopyWithImpl<$Res>
    extends _$SearchActionCopyWithImpl<$Res>
    implements $ResultSearchActionCopyWith<$Res> {
  _$ResultSearchActionCopyWithImpl(
      ResultSearchAction _value, $Res Function(ResultSearchAction) _then)
      : super(_value, (v) => _then(v as ResultSearchAction));

  @override
  ResultSearchAction get _value => super._value as ResultSearchAction;

  @override
  $Res call({
    Object? sights = freezed,
  }) {
    return _then(ResultSearchAction(
      sights == freezed
          ? _value.sights
          : sights // ignore: cast_nullable_to_non_nullable
              as List<Sight>,
    ));
  }
}

/// @nodoc

class _$ResultSearchAction extends ResultSearchAction {
  const _$ResultSearchAction(final List<Sight> sights)
      : _sights = sights,
        super._();

  final List<Sight> _sights;
  @override
  List<Sight> get sights {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sights);
  }

  @override
  String toString() {
    return 'SearchAction.result(sights: $sights)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResultSearchAction &&
            const DeepCollectionEquality().equals(other.sights, sights));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(sights));

  @JsonKey(ignore: true)
  @override
  $ResultSearchActionCopyWith<ResultSearchAction> get copyWith =>
      _$ResultSearchActionCopyWithImpl<ResultSearchAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pattern) start,
    required TResult Function(List<Sight> sights) result,
    required TResult Function(Object error) error,
  }) {
    return result(sights);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
  }) {
    return result?.call(sights);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(sights);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartSearchAction value) start,
    required TResult Function(ResultSearchAction value) result,
    required TResult Function(ErrorSearchAction value) error,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class ResultSearchAction extends SearchAction {
  const factory ResultSearchAction(final List<Sight> sights) =
      _$ResultSearchAction;
  const ResultSearchAction._() : super._();

  List<Sight> get sights => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultSearchActionCopyWith<ResultSearchAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorSearchActionCopyWith<$Res> {
  factory $ErrorSearchActionCopyWith(
          ErrorSearchAction value, $Res Function(ErrorSearchAction) then) =
      _$ErrorSearchActionCopyWithImpl<$Res>;
  $Res call({Object error});
}

/// @nodoc
class _$ErrorSearchActionCopyWithImpl<$Res>
    extends _$SearchActionCopyWithImpl<$Res>
    implements $ErrorSearchActionCopyWith<$Res> {
  _$ErrorSearchActionCopyWithImpl(
      ErrorSearchAction _value, $Res Function(ErrorSearchAction) _then)
      : super(_value, (v) => _then(v as ErrorSearchAction));

  @override
  ErrorSearchAction get _value => super._value as ErrorSearchAction;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(ErrorSearchAction(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
    ));
  }
}

/// @nodoc

class _$ErrorSearchAction extends ErrorSearchAction {
  const _$ErrorSearchAction(this.error) : super._();

  @override
  final Object error;

  @override
  String toString() {
    return 'SearchAction.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorSearchAction &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $ErrorSearchActionCopyWith<ErrorSearchAction> get copyWith =>
      _$ErrorSearchActionCopyWithImpl<ErrorSearchAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pattern) start,
    required TResult Function(List<Sight> sights) result,
    required TResult Function(Object error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pattern)? start,
    TResult Function(List<Sight> sights)? result,
    TResult Function(Object error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StartSearchAction value) start,
    required TResult Function(ResultSearchAction value) result,
    required TResult Function(ErrorSearchAction value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StartSearchAction value)? start,
    TResult Function(ResultSearchAction value)? result,
    TResult Function(ErrorSearchAction value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorSearchAction extends SearchAction {
  const factory ErrorSearchAction(final Object error) = _$ErrorSearchAction;
  const ErrorSearchAction._() : super._();

  Object get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorSearchActionCopyWith<ErrorSearchAction> get copyWith =>
      throw _privateConstructorUsedError;
}
