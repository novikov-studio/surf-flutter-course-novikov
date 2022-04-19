import 'package:places/data/rest/rest_exception.dart';
import 'package:places/ui/const/app_strings.dart';

/// Человекочитаемые описания ошибок.
abstract class Errors {
  /// Текст ошибки для отображения пользователю.
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
  /// Некритичные ошибки, отображаются желтым.
  static const _warnings = <Type, String>{
    // Ошибки связи
    ConnectTimeoutException: AppStrings.connectTimeout,
    SendTimeoutException: AppStrings.sendTimeout,
    ReceiveTimeoutException: AppStrings.receiveTimeout,
    RequestCanceledException: AppStrings.requestCanceled,
    ConnectionRefusedException: AppStrings.connectionRefused,
    FailedHostLookupException: AppStrings.failedHostLookup,
  };

  /// Критичные ошибки, отображаются красным.
  ///
  /// Неизвестные ошибки также считаются критичными.
  static const _errors = <Type, String>{
    // Ошибки сервера
    SrvInvalidRequestException: AppStrings.srvInvalidRequest,
    SrvDuplicateException: AppStrings.srvDuplicate,
    SrvNotFoundException: AppStrings.srvNotFound,
  };

  /// Текст ошибки для отображения пользователю.
  String get humanReadableText =>
      _errors[runtimeType] ?? _warnings[runtimeType] ?? AppStrings.unknownError;

  /// Признак известной ошибки.
  bool get isKnown =>
      _errors.containsKey(runtimeType) || _warnings.containsKey(runtimeType);

  /// Признак неизвестной ошибки.
  bool get isUnknown => !isKnown;

  /// Признак критической ошибки.
  bool get isCritical => !_warnings.containsKey(runtimeType);
}
