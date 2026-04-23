import 'package:logger/logger.dart';
import '../constants/api_constants.dart';

/// Centralised logger — silent in prod, verbose in dev/qa.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 2, lineLength: 80),
    level: AppConstants.isLoggingEnabled ? Level.debug : Level.off,
  );

  static void d(String message, {Object? error}) =>
      _logger.d(message, error: error);

  static void i(String message) => _logger.i(message);

  static void w(String message, {Object? error}) =>
      _logger.w(message, error: error);

  static void e(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

