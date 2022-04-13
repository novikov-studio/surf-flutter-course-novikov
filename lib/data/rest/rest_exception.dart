/// Ошибки сетевого взаимодействия.
///
/// Позволяют абстрагироваться от Dio.
abstract class RestException implements Exception {
  @override
  String toString() {
    final name = runtimeType.toString();

    return name.endsWith('Exception')
        ? name.substring(0, name.length - 9)
        : name;
  }
}

/// Ошибки связи.
class ConnectTimeoutException extends RestException {}

class SendTimeoutException extends RestException {}

class ReceiveTimeoutException extends RestException {}

class RequestCanceledException extends RestException {}

class ConnectionRefusedException extends RestException {}

/// Ошибки сервера.
class ServerException extends RestException {}

class SrvInvalidRequestException extends ServerException {}

class SrvDuplicateException extends ServerException {}

class SrvNotFoundException extends ServerException {}
