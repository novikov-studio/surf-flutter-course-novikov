import 'package:places/data/rest/rest_exception.dart';
import 'package:places/ui/const/app_strings.dart';

/// Человекочитаемые описания ошибок.
abstract class Errors {
  static String humanReadableText(Object error) {
    if (error is String) {
      return error;
    }
    if (error is Exception) {
      return error.humanReadableText;
    }

    return AppStrings.unknownError;
  }
}

extension ExceptionExt on Exception {
  static const _errors = <Type, String>{
    // Ошибки связи
    ConnectTimeoutException: AppStrings.connectTimeout,
    SendTimeoutException: AppStrings.sendTimeout,
    ReceiveTimeoutException: AppStrings.receiveTimeout,
    RequestCanceledException: AppStrings.requestCanceled,
    ConnectionRefusedException: AppStrings.connectionRefused,
    FailedHostLookupException: AppStrings.failedHostLookup,
    // Ошибки сервера
    SrvInvalidRequestException: AppStrings.srvInvalidRequest,
    SrvDuplicateException: AppStrings.srvDuplicate,
    SrvNotFoundException: AppStrings.srvNotFound,
  };

  String get humanReadableText =>
      _errors[runtimeType] ?? AppStrings.unknownError;

  bool get isKnown => this is RestException;

  bool get isUnknown => !isKnown;
}
