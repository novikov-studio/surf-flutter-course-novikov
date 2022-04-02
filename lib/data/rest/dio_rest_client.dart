import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/rest/dio_log_interceptor.dart';
import 'package:places/data/rest/rest_client.dart';
import 'package:places/data/rest/rest_exception.dart';

/// Реализация [RestClient] с помощью библиотеки Dio.
///
/// Конвертация JSON из строки в Map производится с помощью compute.
class DioRestClient implements RestClient {
  final Dio _dio;

  Dio get dio => _dio;

  DioRestClient({required String baseUrl, HttpClientAdapter? adapter})
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
        )
          ..transformer = _ComputeTransformer()
          ..interceptors.add(
            DioLogInterceptor(maxDataLines: 10),
          ) {
    if (adapter != null) {
      _dio.httpClientAdapter = adapter;
    }
  }

  /// GET-запрос
  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
  }) async =>
      _request(
        path,
        method: 'GET',
        params: params,
      );

  /// POST-запрос
  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async =>
      _request(
        path,
        method: 'POST',
        params: params,
        data: data,
      );

  /// POST-запрос
  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async =>
      _request(
        path,
        method: 'PUT',
        params: params,
        data: data,
      );

  /// DELETE-запрос
  @override
  Future<void> delete(
    String path, {
    Map<String, dynamic>? params,
  }) async =>
      _request(
        path,
        method: 'DELETE',
        params: params,
      );

  /// HTTP-запрос
  Future<dynamic> _request(
    String path, {
    required String method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.request<dynamic>(
        path,
        queryParameters: params,
        data: data,
        options: Options(method: method),
      );

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

      case DioErrorType.response:
        _processServerError(err.response?.statusCode);
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

  /// Обработчик ошибок сервера.
  void _processServerError(int? statusCode) {
    switch (statusCode) {
      case 400:
        throw SrvInvalidRequestException();
      case 404:
        throw SrvNotFoundException();
      case 409:
        throw SrvDuplicateException();
    }
  }
}

/// Преобразование json-строки в Map в отдельном пототоке.
class _ComputeTransformer extends DefaultTransformer {
  _ComputeTransformer() : super(jsonDecodeCallback: _parseJson);
}

dynamic _parseJson(String text) => compute<String, dynamic>(jsonDecode, text);
