import 'package:flutter/material.dart';

/// Виджет для отображения данных потока с индикацией загрузки и ошибок.
///
/// Если в поток приходит T, вызывается builder.
/// Если в поток приходит ошибка, вызывается errorBuilder.
/// Если в поток приходит любой другой тип, вызывается loadingBuilder.
@Deprecated('Заменен на [ObservableFutureBuilder]')
class StreamStateBuilder<T> extends StatelessWidget {
  final Stream<dynamic> stream;
  final Widget Function(BuildContext, T) builder;
  final WidgetBuilder loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?) errorBuilder;

  @Deprecated('Заменен на [ObservableFutureBuilder]')
  const StreamStateBuilder({
    Key? key,
    required this.stream,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorBuilder(
            context,
            snapshot.error!,
            snapshot.stackTrace,
          );
        } else if (snapshot.hasData && snapshot.data is T) {
          return builder(
            context,
            snapshot.data as T,
          );
        }

        return loadingBuilder(context);
      },
    );
  }
}
