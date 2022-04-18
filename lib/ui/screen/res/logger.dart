import 'package:flutter/foundation.dart';
import 'package:places/ui/const/errors.dart';

void logErrorIfUnknown(Exception error, StackTrace stacktrace) {
  if (error.isUnknown) {
    debugPrint('$error\n$stacktrace');
  }
}
