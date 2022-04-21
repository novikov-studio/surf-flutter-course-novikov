// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  final SearchState _value;
  // ignore: unused_field
  final $Res Function(SearchState) _then;
}

/// @nodoc
abstract class $InitialSearchStateCopyWith<$Res> {
  factory $InitialSearchStateCopyWith(
          InitialSearchState value, $Res Function(InitialSearchState) then) =
      _$InitialSearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialSearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $InitialSearchStateCopyWith<$Res> {
  _$InitialSearchStateCopyWithImpl(
      InitialSearchState _value, $Res Function(InitialSearchState) _then)
      : super(_value, (v) => _then(v as InitialSearchState));

  @override
  InitialSearchState get _value => super._value as InitialSearchState;
}

/// @nodoc

class _$InitialSearchState extends InitialSearchState {
  const _$InitialSearchState() : super._();

  @override
  String toString() {
    return 'SearchState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InitialSearchState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialSearchState extends SearchState {
  const factory InitialSearchState() = _$InitialSearchState;
  const InitialSearchState._() : super._();
}

/// @nodoc
abstract class $LoadingSearchStateCopyWith<$Res> {
  factory $LoadingSearchStateCopyWith(
          LoadingSearchState value, $Res Function(LoadingSearchState) then) =
      _$LoadingSearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingSearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $LoadingSearchStateCopyWith<$Res> {
  _$LoadingSearchStateCopyWithImpl(
      LoadingSearchState _value, $Res Function(LoadingSearchState) _then)
      : super(_value, (v) => _then(v as LoadingSearchState));

  @override
  LoadingSearchState get _value => super._value as LoadingSearchState;
}

/// @nodoc

class _$LoadingSearchState extends LoadingSearchState {
  const _$LoadingSearchState() : super._();

  @override
  String toString() {
    return 'SearchState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadingSearchState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingSearchState extends SearchState {
  const factory LoadingSearchState() = _$LoadingSearchState;
  const LoadingSearchState._() : super._();
}

/// @nodoc
abstract class $FoundSearchStateCopyWith<$Res> {
  factory $FoundSearchStateCopyWith(
          FoundSearchState value, $Res Function(FoundSearchState) then) =
      _$FoundSearchStateCopyWithImpl<$Res>;
  $Res call({List<Sight> sights});
}

/// @nodoc
class _$FoundSearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $FoundSearchStateCopyWith<$Res> {
  _$FoundSearchStateCopyWithImpl(
      FoundSearchState _value, $Res Function(FoundSearchState) _then)
      : super(_value, (v) => _then(v as FoundSearchState));

  @override
  FoundSearchState get _value => super._value as FoundSearchState;

  @override
  $Res call({
    Object? sights = freezed,
  }) {
    return _then(FoundSearchState(
      sights == freezed
          ? _value.sights
          : sights // ignore: cast_nullable_to_non_nullable
              as List<Sight>,
    ));
  }
}

/// @nodoc

class _$FoundSearchState extends FoundSearchState {
  const _$FoundSearchState(final List<Sight> sights)
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
    return 'SearchState.found(sights: $sights)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FoundSearchState &&
            const DeepCollectionEquality().equals(other.sights, sights));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(sights));

  @JsonKey(ignore: true)
  @override
  $FoundSearchStateCopyWith<FoundSearchState> get copyWith =>
      _$FoundSearchStateCopyWithImpl<FoundSearchState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) {
    return found(sights);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) {
    return found?.call(sights);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) {
    if (found != null) {
      return found(sights);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) {
    return found(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) {
    return found?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) {
    if (found != null) {
      return found(this);
    }
    return orElse();
  }
}

abstract class FoundSearchState extends SearchState {
  const factory FoundSearchState(final List<Sight> sights) = _$FoundSearchState;
  const FoundSearchState._() : super._();

  List<Sight> get sights => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoundSearchStateCopyWith<FoundSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmptySearchStateCopyWith<$Res> {
  factory $EmptySearchStateCopyWith(
          EmptySearchState value, $Res Function(EmptySearchState) then) =
      _$EmptySearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmptySearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $EmptySearchStateCopyWith<$Res> {
  _$EmptySearchStateCopyWithImpl(
      EmptySearchState _value, $Res Function(EmptySearchState) _then)
      : super(_value, (v) => _then(v as EmptySearchState));

  @override
  EmptySearchState get _value => super._value as EmptySearchState;
}

/// @nodoc

class _$EmptySearchState extends EmptySearchState {
  const _$EmptySearchState() : super._();

  @override
  String toString() {
    return 'SearchState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EmptySearchState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class EmptySearchState extends SearchState {
  const factory EmptySearchState() = _$EmptySearchState;
  const EmptySearchState._() : super._();
}

/// @nodoc
abstract class $ErrorSearchStateCopyWith<$Res> {
  factory $ErrorSearchStateCopyWith(
          ErrorSearchState value, $Res Function(ErrorSearchState) then) =
      _$ErrorSearchStateCopyWithImpl<$Res>;
  $Res call({String message, bool critical});
}

/// @nodoc
class _$ErrorSearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements $ErrorSearchStateCopyWith<$Res> {
  _$ErrorSearchStateCopyWithImpl(
      ErrorSearchState _value, $Res Function(ErrorSearchState) _then)
      : super(_value, (v) => _then(v as ErrorSearchState));

  @override
  ErrorSearchState get _value => super._value as ErrorSearchState;

  @override
  $Res call({
    Object? message = freezed,
    Object? critical = freezed,
  }) {
    return _then(ErrorSearchState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      critical: critical == freezed
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ErrorSearchState extends ErrorSearchState {
  const _$ErrorSearchState({required this.message, required this.critical})
      : super._();

  @override
  final String message;
  @override
  final bool critical;

  @override
  String toString() {
    return 'SearchState.error(message: $message, critical: $critical)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorSearchState &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.critical, critical));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(critical));

  @JsonKey(ignore: true)
  @override
  $ErrorSearchStateCopyWith<ErrorSearchState> get copyWith =>
      _$ErrorSearchStateCopyWithImpl<ErrorSearchState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Sight> sights) found,
    required TResult Function() empty,
    required TResult Function(String message, bool critical) error,
  }) {
    return error(message, critical);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
  }) {
    return error?.call(message, critical);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Sight> sights)? found,
    TResult Function()? empty,
    TResult Function(String message, bool critical)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, critical);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialSearchState value) initial,
    required TResult Function(LoadingSearchState value) loading,
    required TResult Function(FoundSearchState value) found,
    required TResult Function(EmptySearchState value) empty,
    required TResult Function(ErrorSearchState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialSearchState value)? initial,
    TResult Function(LoadingSearchState value)? loading,
    TResult Function(FoundSearchState value)? found,
    TResult Function(EmptySearchState value)? empty,
    TResult Function(ErrorSearchState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorSearchState extends SearchState {
  const factory ErrorSearchState(
      {required final String message,
      required final bool critical}) = _$ErrorSearchState;
  const ErrorSearchState._() : super._();

  String get message => throw _privateConstructorUsedError;
  bool get critical => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorSearchStateCopyWith<ErrorSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
