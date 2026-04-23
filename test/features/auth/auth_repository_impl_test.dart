import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_kart_ai/core/constants/api_constants.dart';
import 'package:smart_kart_ai/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:smart_kart_ai/features/auth/data/models/user_model.dart';
import 'package:smart_kart_ai/features/auth/data/repositories/auth_repository_impl.dart';

class FakeAuthRemoteDatasource implements AuthRemoteDatasource {
  @override
  Future<({String accessToken, String refreshToken, UserModel user})> login({
	required String email,
	required String password,
  }) async {
	return (
	  accessToken: 'token-123',
	  refreshToken: 'refresh-123',
	  user: UserModel(id: 1, name: 'Admin', email: email, role: 'admin'),
	);
  }

  @override
  Future<UserModel> getProfile() async {
	return const UserModel(
	  id: 1,
	  name: 'Admin',
	  email: 'admin@mail.com',
	  role: 'admin',
	);
  }
}

class FakeFlutterSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<void> write({
	required String key,
	String? value,
	AppleOptions? iOptions,
	AndroidOptions? aOptions,
	LinuxOptions? lOptions,
	WebOptions? webOptions,
	WindowsOptions? wOptions,
	MacOsOptions? mOptions,
  }) async {
	if (value == null) {
	  _store.remove(key);
	} else {
	  _store[key] = value;
	}
  }

  @override
  Future<String?> read({
	required String key,
	AppleOptions? iOptions,
	AndroidOptions? aOptions,
	LinuxOptions? lOptions,
	WebOptions? webOptions,
	WindowsOptions? wOptions,
	MacOsOptions? mOptions,
  }) async {
	return _store[key];
  }
}

void main() {
  late FakeAuthRemoteDatasource remoteDatasource;
  late FakeFlutterSecureStorage secureStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
	remoteDatasource = FakeAuthRemoteDatasource();
	secureStorage = FakeFlutterSecureStorage();
	repository = AuthRepositoryImpl(remoteDatasource, secureStorage);
  });

  test('login stores tokens and returns authenticated user tuple', () async {
	final result = await repository.login(
	  email: 'admin@mail.com',
	  password: 'admin123',
	);

	expect(result.user.email, 'admin@mail.com');
	expect(
	  await secureStorage.read(key: AppConstants.tokenKey),
	  'token-123',
	);
	expect(
	  await secureStorage.read(key: AppConstants.refreshTokenKey),
	  'refresh-123',
	);
  });
}

