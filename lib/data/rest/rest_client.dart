import 'package:places/data/rest/dio_rest_client.dart';

/// Интерфейс REST-клиента.
abstract class RestClient {
  factory RestClient.getInstance({required String baseUrl}) = DioRestClient;

  /// HTTP GET-запрос.
  ///
  /// В [path] должен передаваться относительный путь.
  Future<T> get<T>(String path, {Map<String, dynamic>? params});
}
