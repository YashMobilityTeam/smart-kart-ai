import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<({String accessToken, String refreshToken, UserModel user})> login({
    required String email,
    required String password,
  });
  Future<UserModel> getProfile();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient _client;
  const AuthRemoteDatasourceImpl(this._client);

  @override
  Future<({String accessToken, String refreshToken, UserModel user})> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      return (
        accessToken: res.data['access_token'] as String,
        refreshToken: res.data['refresh_token'] as String,
        user: UserModel.fromJson(res.data['user'] as Map<String, dynamic>? ??
            {'id': 0, 'name': '', 'email': email, 'role': 'customer'}),
      );
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] ?? 'Login failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final res = await _client.get(ApiConstants.profile);
      return UserModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] ?? 'Profile fetch failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}

