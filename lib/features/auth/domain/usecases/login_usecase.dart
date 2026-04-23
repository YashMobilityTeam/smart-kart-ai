import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  /// Returns access token + user on success; throws [AuthFailure] on error.
  Future<({String accessToken, String refreshToken, User user})> call({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
}

