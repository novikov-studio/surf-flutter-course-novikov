import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/data/rest/dio_log_interceptor.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/data/rest/rest_exception.dart';

/// Реализация [RestClient] с помощью библиотеки Dio.
class DioRestClient implements RestClient {
  final Dio _dio;

  DioRestClient({required String baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: 5000,
            receiveTimeout: 5000,
            sendTimeout: 5000,
            headers: <String, dynamic>{
              'user-agent': 'Places 1.0 (${Platform.operatingSystem})',
            },
          ),
        )..interceptors.add(
            DioLogInterceptor(maxDataLines: 10),
          );

  /// GET-запрос
  @override
  Future<T> get<T>(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: params);

      return response.data!;
    } on DioError catch (e) {
      _processDioError(e);
      rethrow;
    }
  }

  /// Обработчик ошибок Dio-клиента.
  void _processDioError(DioError err) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        throw ConnectTimeoutException();

      case DioErrorType.sendTimeout:
        throw SendTimeoutException();

      case DioErrorType.receiveTimeout:
        throw ReceiveTimeoutException();

      case DioErrorType.cancel:
        throw RequestCanceledException();

      case DioErrorType.other:
        if (err.error != null) {
          _processSocketError(err.error);
        }
        break;

      default:
        break;
    }
  }

  /// Обработчик ошибок сокета.
  // ignore: avoid_annotating_with_dynamic
  void _processSocketError(dynamic error) {
    if (error is SocketException) {
      if (error.message.contains('Connection refused')) {
        throw ConnectionRefusedException();
      }
    }
  }
}
