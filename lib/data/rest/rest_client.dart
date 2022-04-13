import 'package:places/data/rest/dio_rest_client.dart';

/// Интерфейс REST-клиента.
abstract class RestClient {
  factory RestClient.getInstance({required String baseUrl}) = DioRestClient;

  /// HTTP GET-запрос.
  ///
  /// В [path] должен передаваться относительный путь.
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
  });

  /// HTTP POST-запрос.
  ///
  /// В [path] должен передаваться относительный путь.
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  });

  /// HTTP PUT-запрос.
  ///
  /// В [path] должен передаваться относительный путь.
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  });

  /// HTTP DELETE-запрос.
  ///
  /// В [path] должен передаваться относительный путь.
  Future<void> delete(
    String path, {
    Map<String, dynamic>? params,
  });

  /// HTTP POST-запрос для выгрузки файлов на сервер.
  ///
  /// В [path] должен передаваться относительный путь.
  ///
  /// На входе принимает набор "имя файла: содержимое файла",
  /// на выходе - набор "имя файла: url".
  Future<Map<String, String>> upload(
    String path, {
    required Map<String, List<int>> files,
  });
}
