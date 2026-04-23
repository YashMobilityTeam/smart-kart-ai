import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import '../utils/app_logger.dart';

/// Attaches JWT Bearer token to every request and handles 401 token refresh.
class AuthInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: AppConstants.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Attempt token refresh
      try {
        final refreshToken =
            await _storage.read(key: AppConstants.refreshTokenKey);
        if (refreshToken == null) {
          handler.next(err);
          return;
        }
        final dio = Dio();
        final response = await dio.post(
          '${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
          data: {'refreshToken': refreshToken},
        );
        final newToken = response.data['access_token'] as String;
        await _storage.write(key: AppConstants.tokenKey, value: newToken);

        // Retry original request with new token
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await dio.fetch(err.requestOptions);
        handler.resolve(retryResponse);
      } catch (_) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}

/// Logs requests & responses in non-production environments.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('→ ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d('← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('✗ ${err.response?.statusCode} ${err.requestOptions.uri}',
        error: err);
    handler.next(err);
  }
}


