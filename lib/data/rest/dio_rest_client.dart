import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
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

  /// UPLOAD (POST + multipart form)
  @override
  Future<Map<String, String>> upload(
    String path, {
    required Map<String, List<int>> files,
  }) async {
    final response = await _rawRequest(
      path,
      method: 'POST',
      data: FormData.fromMap(
        files.map<String, MultipartFile>(
          (key, value) => MapEntry(
            key,
            MultipartFile.fromBytes(
              value,
              contentType: _detectMediaType(key),
            ),
          ),
        ),
      ),
    );

    final baseUrl = _dio.options.baseUrl;

    if (files.length == 1) {
      return <String, String>{
        files.keys.first: '$baseUrl/${response.headers.value('location')!}',
      };
    } else {
      final data = response.data as Map<String, dynamic>;
      final urls = data['urls'] as List;

      return files.keys.toList().asMap().map<String, String>(
            (key, value) => MapEntry(value, '$baseUrl/${urls[key]}'),
          );
    }
  }

  /// Надстройка над [_rawRequest] для обычных запросов.
  Future<dynamic> _request(
    String path, {
    required String method,
    Map<String, dynamic>? params,
    // ignore: avoid_annotating_with_dynamic
    dynamic data,
  }) async {
    final response = await _rawRequest(
      path,
      method: method,
      params: params,
      data: data,
    );

    return response.data!;
  }

  /// Базовый HTTP-запрос.
  Future<Response> _rawRequest(
    String path, {
    required String method,
    Map<String, dynamic>? params,
    // ignore: avoid_annotating_with_dynamic
    dynamic data,
  }) async {
    try {
      return await dio.request<dynamic>(
        path,
        queryParameters: params,
        data: data,
        options: Options(method: method),
      );
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
      if (error.message.contains('Failed host lookup')) {
        throw FailedHostLookupException();
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

  /// Определяет MIME-тип по имени файла.
  MediaType? _detectMediaType(String fileName) {
    final index = fileName.lastIndexOf('.');
    if (index < 0) {
      return null;
    }

    final ext = fileName.substring(index + 1).toLowerCase();

    switch (ext) {
      case 'jpeg':
      case 'jpg':
        return MediaType('image', 'jpeg');

      case 'png':
        return MediaType('image', 'png');

      case 'gif':
        return MediaType('image', 'gif');

      case 'svg':
        return MediaType('image', 'svg+xml');

      default:
        return null;
    }
  }
}

/// Преобразование json-строки в Map в отдельном пототоке.
class _ComputeTransformer extends DefaultTransformer {
  _ComputeTransformer() : super(jsonDecodeCallback: _parseJson);
}

dynamic _parseJson(String text) => compute<String, dynamic>(jsonDecode, text);
