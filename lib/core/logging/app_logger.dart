import 'package:flutter/foundation.dart';

class AppLogger {
  void info(String message) {
    if (kDebugMode) {
      debugPrint('INFO: $message');
    }
  }

  void error(String message, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('ERROR: $message');
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
  }

  void logFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
  }
}
