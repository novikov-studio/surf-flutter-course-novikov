import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// [StateNotifierBuilder] analog with [child] property.
class StateNotifierBuilderEx<T> extends StatefulWidget {
  /// State that used to detect change and rebuild.
  final ListenableState<T> listenableState;

  /// Function that used to describe the part of the user interface
  /// represented by this widget.
  final Widget Function(BuildContext context, T? value, Widget? child) builder;

  final Widget? child;

  /// Create an instance of StateNotifierBuilder.
  const StateNotifierBuilderEx({
    Key? key,
    required this.listenableState,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  _StateNotifierBuilderStateEx createState() =>
      _StateNotifierBuilderStateEx<T>();
}

class _StateNotifierBuilderStateEx<T> extends State<StateNotifierBuilderEx<T>> {
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.listenableState.value;
    widget.listenableState.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(StateNotifierBuilderEx<T> oldWidget) {
    if (oldWidget.listenableState != widget.listenableState) {
      oldWidget.listenableState.removeListener(_valueChanged);
      value = widget.listenableState.value;
      widget.listenableState.addListener(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.listenableState.removeListener(_valueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }

  void _valueChanged() {
    setState(() {
      value = widget.listenableState.value;
    });
  }
}

extension EntityStateExt<T> on EntityState<T> {
  bool get isInitial => data == null && !isLoading && !hasError;
}

extension EntityStateNotifierExt<T> on EntityStateNotifier<T> {
  void initial() =>
      accept(EntityState<T>());
}

/// Analog for [EntityStateNotifierBuilder] with initial builder.
//ignore: prefer-single-widget-per-file
class EntityStateNotifierBuilderEx<T> extends StatelessWidget {
  /// State that used to detect change and rebuild.
  final ListenableState<EntityState<T>> listenableEntityState;

  /// Builder that used to describe user interface when get data.
  final DataWidgetBuilder<T> builder;

  /// Builder that used to describe user interface when initial.
  final InitialWidgetBuilder<T>? initialBuilder;

  /// Builder that used to describe user interface when loading.
  final LoadingWidgetBuilder<T>? loadingBuilder;

  /// Builder that used to describe user interface when get error.
  final ErrorWidgetBuilder<T>? errorBuilder;

  /// Create an instance of EntityStateNotifierBuilder.
  const EntityStateNotifierBuilderEx({
    Key? key,
    required this.listenableEntityState,
    required this.builder,
    this.initialBuilder,
    this.loadingBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<EntityState<T>>(
      listenableState: listenableEntityState,
      builder: (ctx, state) {
        final entity = state!;

        final iBuilder = initialBuilder;
        if (entity.isInitial && iBuilder != null) {
          return iBuilder(ctx);
        }

        final eBuilder = errorBuilder;
        if (entity.hasError && eBuilder != null) {
          return eBuilder(ctx, entity.error, entity.data);
        }

        final lBuilder = loadingBuilder;
        if (entity.isLoading && lBuilder != null) {
          return lBuilder(ctx, entity.data);
        }

        return builder(ctx, entity.data);
      },
    );
  }
}

/// Builder function for initial state.
/// See also:
///   [EntityState] - State of some logical entity.
typedef InitialWidgetBuilder<T> = Widget Function(
  BuildContext context,
);

/// Builder function for loading state.
/// See also:
///   [EntityState] - State of some logical entity.
typedef LoadingWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
);

/// Builder function for content state.
/// See also:
///   [EntityState] - State of some logical entity.
typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T? data);

/// Builder function for error state.
/// See also:
///   [EntityState] - State of some logical entity.
typedef ErrorWidgetBuilder<T> = Widget Function(
  BuildContext context,
  Exception? e,
  T? data,
);
