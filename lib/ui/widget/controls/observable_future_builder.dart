import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

/// Виджет для отображения данных из [ObservableFuture] с индикацией загрузки и ошибок.
class ObservableFutureBuilder<T> extends StatelessWidget {
  final ObservableFuture<T> future;
  final Widget Function(BuildContext, T) builder;
  final WidgetBuilder loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?) errorBuilder;

  const ObservableFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (future.isLoading) {
          return loadingBuilder(context);
        }

        if (future.error != null) {
          return errorBuilder(context, future.error as Object, null);
        }

        return builder(context, future.value!);
      },
    );
  }
}

extension ObservableFutureExt on ObservableFuture {
  bool get isLoading => status == FutureStatus.pending;
}
