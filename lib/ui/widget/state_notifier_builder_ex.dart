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
  _StateNotifierBuilderStateEx createState() => _StateNotifierBuilderStateEx<T>();
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
