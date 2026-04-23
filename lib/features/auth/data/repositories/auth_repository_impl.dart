import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;
  final FlutterSecureStorage _storage;
  const AuthRepositoryImpl(this._remote, this._storage);
  @override
  Future<({String accessToken, String refreshToken, User user})> login({
    required String email,
    required String password,
  }) async {
    final result = await _remote.login(email: email, password: password);
    await _storage.write(key: AppConstants.tokenKey, value: result.accessToken);
    await _storage.write(
      key: AppConstants.refreshTokenKey,
      value: result.refreshToken,
    );
    return result;
  }
  @override
  Future<User> getProfile() => _remote.getProfile();
  @override
  Future<void> logout() async => _storage.deleteAll();
}
