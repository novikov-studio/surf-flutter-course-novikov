// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../../../ui/bloc/visiting_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisitingBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hidden) load,
    required TResult Function(int sourceId, int? insertBeforeId) reorder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadVisitingBlocEvent value) load,
    required TResult Function(ReorderVisitingBlocEvent value) reorder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitingBlocEventCopyWith<$Res> {
  factory $VisitingBlocEventCopyWith(
          VisitingBlocEvent value, $Res Function(VisitingBlocEvent) then) =
      _$VisitingBlocEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$VisitingBlocEventCopyWithImpl<$Res>
    implements $VisitingBlocEventCopyWith<$Res> {
  _$VisitingBlocEventCopyWithImpl(this._value, this._then);

  final VisitingBlocEvent _value;
  // ignore: unused_field
  final $Res Function(VisitingBlocEvent) _then;
}

/// @nodoc
abstract class $LoadVisitingBlocEventCopyWith<$Res> {
  factory $LoadVisitingBlocEventCopyWith(LoadVisitingBlocEvent value,
          $Res Function(LoadVisitingBlocEvent) then) =
      _$LoadVisitingBlocEventCopyWithImpl<$Res>;
  $Res call({bool hidden});
}

/// @nodoc
class _$LoadVisitingBlocEventCopyWithImpl<$Res>
    extends _$VisitingBlocEventCopyWithImpl<$Res>
    implements $LoadVisitingBlocEventCopyWith<$Res> {
  _$LoadVisitingBlocEventCopyWithImpl(
      LoadVisitingBlocEvent _value, $Res Function(LoadVisitingBlocEvent) _then)
      : super(_value, (v) => _then(v as LoadVisitingBlocEvent));

  @override
  LoadVisitingBlocEvent get _value => super._value as LoadVisitingBlocEvent;

  @override
  $Res call({
    Object? hidden = freezed,
  }) {
    return _then(LoadVisitingBlocEvent(
      hidden: hidden == freezed
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadVisitingBlocEvent extends LoadVisitingBlocEvent {
  const _$LoadVisitingBlocEvent({this.hidden = true}) : super._();

  @override
  @JsonKey()
  final bool hidden;

  @override
  String toString() {
    return 'VisitingBlocEvent.load(hidden: $hidden)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadVisitingBlocEvent &&
            const DeepCollectionEquality().equals(other.hidden, hidden));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(hidden));

  @JsonKey(ignore: true)
  @override
  $LoadVisitingBlocEventCopyWith<LoadVisitingBlocEvent> get copyWith =>
      _$LoadVisitingBlocEventCopyWithImpl<LoadVisitingBlocEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hidden) load,
    required TResult Function(int sourceId, int? insertBeforeId) reorder,
  }) {
    return load(hidden);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
  }) {
    return load?.call(hidden);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(hidden);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadVisitingBlocEvent value) load,
    required TResult Function(ReorderVisitingBlocEvent value) reorder,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadVisitingBlocEvent extends VisitingBlocEvent {
  const factory LoadVisitingBlocEvent({final bool hidden}) =
      _$LoadVisitingBlocEvent;
  const LoadVisitingBlocEvent._() : super._();

  bool get hidden => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadVisitingBlocEventCopyWith<LoadVisitingBlocEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReorderVisitingBlocEventCopyWith<$Res> {
  factory $ReorderVisitingBlocEventCopyWith(ReorderVisitingBlocEvent value,
          $Res Function(ReorderVisitingBlocEvent) then) =
      _$ReorderVisitingBlocEventCopyWithImpl<$Res>;
  $Res call({int sourceId, int? insertBeforeId});
}

/// @nodoc
class _$ReorderVisitingBlocEventCopyWithImpl<$Res>
    extends _$VisitingBlocEventCopyWithImpl<$Res>
    implements $ReorderVisitingBlocEventCopyWith<$Res> {
  _$ReorderVisitingBlocEventCopyWithImpl(ReorderVisitingBlocEvent _value,
      $Res Function(ReorderVisitingBlocEvent) _then)
      : super(_value, (v) => _then(v as ReorderVisitingBlocEvent));

  @override
  ReorderVisitingBlocEvent get _value =>
      super._value as ReorderVisitingBlocEvent;

  @override
  $Res call({
    Object? sourceId = freezed,
    Object? insertBeforeId = freezed,
  }) {
    return _then(ReorderVisitingBlocEvent(
      sourceId: sourceId == freezed
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as int,
      insertBeforeId: insertBeforeId == freezed
          ? _value.insertBeforeId
          : insertBeforeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ReorderVisitingBlocEvent extends ReorderVisitingBlocEvent {
  const _$ReorderVisitingBlocEvent(
      {required this.sourceId, this.insertBeforeId})
      : super._();

  @override
  final int sourceId;
  @override
  final int? insertBeforeId;

  @override
  String toString() {
    return 'VisitingBlocEvent.reorder(sourceId: $sourceId, insertBeforeId: $insertBeforeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReorderVisitingBlocEvent &&
            const DeepCollectionEquality().equals(other.sourceId, sourceId) &&
            const DeepCollectionEquality()
                .equals(other.insertBeforeId, insertBeforeId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(sourceId),
      const DeepCollectionEquality().hash(insertBeforeId));

  @JsonKey(ignore: true)
  @override
  $ReorderVisitingBlocEventCopyWith<ReorderVisitingBlocEvent> get copyWith =>
      _$ReorderVisitingBlocEventCopyWithImpl<ReorderVisitingBlocEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hidden) load,
    required TResult Function(int sourceId, int? insertBeforeId) reorder,
  }) {
    return reorder(sourceId, insertBeforeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
  }) {
    return reorder?.call(sourceId, insertBeforeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hidden)? load,
    TResult Function(int sourceId, int? insertBeforeId)? reorder,
    required TResult orElse(),
  }) {
    if (reorder != null) {
      return reorder(sourceId, insertBeforeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadVisitingBlocEvent value) load,
    required TResult Function(ReorderVisitingBlocEvent value) reorder,
  }) {
    return reorder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
  }) {
    return reorder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadVisitingBlocEvent value)? load,
    TResult Function(ReorderVisitingBlocEvent value)? reorder,
    required TResult orElse(),
  }) {
    if (reorder != null) {
      return reorder(this);
    }
    return orElse();
  }
}

abstract class ReorderVisitingBlocEvent extends VisitingBlocEvent {
  const factory ReorderVisitingBlocEvent(
      {required final int sourceId,
      final int? insertBeforeId}) = _$ReorderVisitingBlocEvent;
  const ReorderVisitingBlocEvent._() : super._();

  int get sourceId => throw _privateConstructorUsedError;
  int? get insertBeforeId => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReorderVisitingBlocEventCopyWith<ReorderVisitingBlocEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VisitingBlocState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Iterable<Sight> sights) done,
    required TResult Function(String message, ErrorSource source, bool critical)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingVisitingBlocState value) loading,
    required TResult Function(DoneVisitingBlocState value) done,
    required TResult Function(ErrorVisitingBlocState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitingBlocStateCopyWith<$Res> {
  factory $VisitingBlocStateCopyWith(
          VisitingBlocState value, $Res Function(VisitingBlocState) then) =
      _$VisitingBlocStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$VisitingBlocStateCopyWithImpl<$Res>
    implements $VisitingBlocStateCopyWith<$Res> {
  _$VisitingBlocStateCopyWithImpl(this._value, this._then);

  final VisitingBlocState _value;
  // ignore: unused_field
  final $Res Function(VisitingBlocState) _then;
}

/// @nodoc
abstract class $LoadingVisitingBlocStateCopyWith<$Res> {
  factory $LoadingVisitingBlocStateCopyWith(LoadingVisitingBlocState value,
          $Res Function(LoadingVisitingBlocState) then) =
      _$LoadingVisitingBlocStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingVisitingBlocStateCopyWithImpl<$Res>
    extends _$VisitingBlocStateCopyWithImpl<$Res>
    implements $LoadingVisitingBlocStateCopyWith<$Res> {
  _$LoadingVisitingBlocStateCopyWithImpl(LoadingVisitingBlocState _value,
      $Res Function(LoadingVisitingBlocState) _then)
      : super(_value, (v) => _then(v as LoadingVisitingBlocState));

  @override
  LoadingVisitingBlocState get _value =>
      super._value as LoadingVisitingBlocState;
}

/// @nodoc

class _$LoadingVisitingBlocState extends LoadingVisitingBlocState {
  const _$LoadingVisitingBlocState() : super._();

  @override
  String toString() {
    return 'VisitingBlocState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadingVisitingBlocState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Iterable<Sight> sights) done,
    required TResult Function(String message, ErrorSource source, bool critical)
        error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
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
    required TResult Function(LoadingVisitingBlocState value) loading,
    required TResult Function(DoneVisitingBlocState value) done,
    required TResult Function(ErrorVisitingBlocState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingVisitingBlocState extends VisitingBlocState {
  const factory LoadingVisitingBlocState() = _$LoadingVisitingBlocState;
  const LoadingVisitingBlocState._() : super._();
}

/// @nodoc
abstract class $DoneVisitingBlocStateCopyWith<$Res> {
  factory $DoneVisitingBlocStateCopyWith(DoneVisitingBlocState value,
          $Res Function(DoneVisitingBlocState) then) =
      _$DoneVisitingBlocStateCopyWithImpl<$Res>;
  $Res call({Iterable<Sight> sights});
}

/// @nodoc
class _$DoneVisitingBlocStateCopyWithImpl<$Res>
    extends _$VisitingBlocStateCopyWithImpl<$Res>
    implements $DoneVisitingBlocStateCopyWith<$Res> {
  _$DoneVisitingBlocStateCopyWithImpl(
      DoneVisitingBlocState _value, $Res Function(DoneVisitingBlocState) _then)
      : super(_value, (v) => _then(v as DoneVisitingBlocState));

  @override
  DoneVisitingBlocState get _value => super._value as DoneVisitingBlocState;

  @override
  $Res call({
    Object? sights = freezed,
  }) {
    return _then(DoneVisitingBlocState(
      sights == freezed
          ? _value.sights
          : sights // ignore: cast_nullable_to_non_nullable
              as Iterable<Sight>,
    ));
  }
}

/// @nodoc

class _$DoneVisitingBlocState extends DoneVisitingBlocState {
  const _$DoneVisitingBlocState(this.sights) : super._();

  @override
  final Iterable<Sight> sights;

  @override
  String toString() {
    return 'VisitingBlocState.done(sights: $sights)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DoneVisitingBlocState &&
            const DeepCollectionEquality().equals(other.sights, sights));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(sights));

  @JsonKey(ignore: true)
  @override
  $DoneVisitingBlocStateCopyWith<DoneVisitingBlocState> get copyWith =>
      _$DoneVisitingBlocStateCopyWithImpl<DoneVisitingBlocState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Iterable<Sight> sights) done,
    required TResult Function(String message, ErrorSource source, bool critical)
        error,
  }) {
    return done(sights);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
  }) {
    return done?.call(sights);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done(sights);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingVisitingBlocState value) loading,
    required TResult Function(DoneVisitingBlocState value) done,
    required TResult Function(ErrorVisitingBlocState value) error,
  }) {
    return done(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
  }) {
    return done?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done(this);
    }
    return orElse();
  }
}

abstract class DoneVisitingBlocState extends VisitingBlocState {
  const factory DoneVisitingBlocState(final Iterable<Sight> sights) =
      _$DoneVisitingBlocState;
  const DoneVisitingBlocState._() : super._();

  Iterable<Sight> get sights => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoneVisitingBlocStateCopyWith<DoneVisitingBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorVisitingBlocStateCopyWith<$Res> {
  factory $ErrorVisitingBlocStateCopyWith(ErrorVisitingBlocState value,
          $Res Function(ErrorVisitingBlocState) then) =
      _$ErrorVisitingBlocStateCopyWithImpl<$Res>;
  $Res call({String message, ErrorSource source, bool critical});
}

/// @nodoc
class _$ErrorVisitingBlocStateCopyWithImpl<$Res>
    extends _$VisitingBlocStateCopyWithImpl<$Res>
    implements $ErrorVisitingBlocStateCopyWith<$Res> {
  _$ErrorVisitingBlocStateCopyWithImpl(ErrorVisitingBlocState _value,
      $Res Function(ErrorVisitingBlocState) _then)
      : super(_value, (v) => _then(v as ErrorVisitingBlocState));

  @override
  ErrorVisitingBlocState get _value => super._value as ErrorVisitingBlocState;

  @override
  $Res call({
    Object? message = freezed,
    Object? source = freezed,
    Object? critical = freezed,
  }) {
    return _then(ErrorVisitingBlocState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as ErrorSource,
      critical: critical == freezed
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ErrorVisitingBlocState extends ErrorVisitingBlocState {
  const _$ErrorVisitingBlocState(
      {required this.message, required this.source, required this.critical})
      : super._();

  @override
  final String message;
  @override
  final ErrorSource source;
  @override
  final bool critical;

  @override
  String toString() {
    return 'VisitingBlocState.error(message: $message, source: $source, critical: $critical)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorVisitingBlocState &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.critical, critical));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(critical));

  @JsonKey(ignore: true)
  @override
  $ErrorVisitingBlocStateCopyWith<ErrorVisitingBlocState> get copyWith =>
      _$ErrorVisitingBlocStateCopyWithImpl<ErrorVisitingBlocState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Iterable<Sight> sights) done,
    required TResult Function(String message, ErrorSource source, bool critical)
        error,
  }) {
    return error(message, source, critical);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
  }) {
    return error?.call(message, source, critical);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Iterable<Sight> sights)? done,
    TResult Function(String message, ErrorSource source, bool critical)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, source, critical);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingVisitingBlocState value) loading,
    required TResult Function(DoneVisitingBlocState value) done,
    required TResult Function(ErrorVisitingBlocState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingVisitingBlocState value)? loading,
    TResult Function(DoneVisitingBlocState value)? done,
    TResult Function(ErrorVisitingBlocState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorVisitingBlocState extends VisitingBlocState {
  const factory ErrorVisitingBlocState(
      {required final String message,
      required final ErrorSource source,
      required final bool critical}) = _$ErrorVisitingBlocState;
  const ErrorVisitingBlocState._() : super._();

  String get message => throw _privateConstructorUsedError;
  ErrorSource get source => throw _privateConstructorUsedError;
  bool get critical => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorVisitingBlocStateCopyWith<ErrorVisitingBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}
