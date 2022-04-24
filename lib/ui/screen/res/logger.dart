import 'package:flutter/foundation.dart';
import 'package:places/ui/const/errors.dart';

void logError(Object error, [StackTrace? stacktrace]) {
  if (stacktrace != null && Errors.isUnknown(error)) {
    debugPrint('$error\n$stacktrace');
  } else {
    debugPrint('$error');
  }
}
