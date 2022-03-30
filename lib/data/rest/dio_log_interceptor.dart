import 'package:dio/dio.dart';

/// Логгер REST-пакетов.
class DioLogInterceptor extends Interceptor {
  /// Callback для обработки вывода.
  final void Function(Object object) logPrint;

  /// Максимальное кол-во строк для отображения тела запроса/ответа.
  ///
  /// Если поле не задано, тело выводится полностью.
  /// Если значение равно 0, не поле выводится в лог.
  final int? maxDataLines;

  DioLogInterceptor({
    this.logPrint = print,
    this.maxDataLines,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logPrint('>> ${options.method.toUpperCase()} ${options.path}');
    if (options.responseType != ResponseType.json) {
      _printKV('responseType', options.responseType.toString());
    }
    if (options.extra.isNotEmpty) {
      _printKV('extra', options.extra);
    }
    if (options.data != null) {
      logPrint('data:');
      _printAll(options.data);
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    _printResponse(response);
    handler.next(response);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final status = err.response != null
        ? '${err.response!.statusMessage} (${err.response!.statusCode})'
        : 'ERROR';

    logPrint(
      '<< ${err.requestOptions.method} ${err.requestOptions.path} - $status',
    );
    logPrint('$err');
    if (err.response != null) {
      _printResponse(err.response!, title: false);
    }
    logPrint('');

    handler.next(err);
  }

  void _printResponse(Response response, {bool title = true}) {
    final request = response.requestOptions;
    if (title) {
      logPrint(
        '<< ${request.method} ${request.path} - '
        '${response.statusMessage} (${response.statusCode})',
      );
    }

    if (response.data != null) {
      _printAll(response.toString());
    }
    logPrint('');
  }

  void _printKV(String key, Object? v) {
    logPrint('$key: $v');
  }

  // ignore: avoid_annotating_with_dynamic
  void _printAll(dynamic msg) {
    if (maxDataLines == 0) {
      return;
    }

    final lines = msg.toString().split('\n');

    if (maxDataLines != null && lines.length > maxDataLines!) {
      lines.getRange(0, maxDataLines!).forEach(logPrint);
      logPrint('... + ${lines.length - maxDataLines!} lines');
    } else {
      lines.forEach(logPrint);
    }
  }
}
