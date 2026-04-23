import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.escuelajs.co/api/v1';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh-token';
  static const String profile = '/auth/profile';

  // Product endpoints
  static const String products = '/products';
  static const String categories = '/categories';

  // User endpoints
  static const String users = '/users';

  // Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}

class AppConstants {
  AppConstants._();

  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String themeKey = 'app_theme';

  static String get appEnv => dotenv.env['APP_ENV'] ?? 'dev';
  static bool get isLoggingEnabled =>
      dotenv.env['ENABLE_LOGGING'] == 'true';
}

