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
class ConnectException extends RestException {}

class ConnectTimeoutException extends ConnectException {}

class SendTimeoutException extends ConnectException {}

class ReceiveTimeoutException extends ConnectException {}

class RequestCanceledException extends ConnectException {}

class ConnectionRefusedException extends ConnectException {}

class FailedHostLookupException extends ConnectException {}

/// Ошибки сервера.
class ServerException extends RestException {}

class SrvInvalidRequestException extends ServerException {}

class SrvDuplicateException extends ServerException {}

class SrvNotFoundException extends ServerException {}
