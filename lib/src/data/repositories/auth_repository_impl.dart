import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../models/user_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> login({required String email, required String password}) async {
    final UserProfileModel model =
        await _remoteDataSource.login(email: email, password: password);
    return model.toEntity();
  }

  @override
  Future<UserProfile> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final model = await _remoteDataSource.register(
      email: email,
      password: password,
      fullName: fullName,
    );
    return model.toEntity();
  }

  @override
  Future<void> requestPasswordReset({required String email}) {
    return _remoteDataSource.requestPasswordReset(email: email);
  }

  @override
  Future<void> resetPassword({required String token, required String newPassword}) {
    return _remoteDataSource.resetPassword(token: token, newPassword: newPassword);
  }

  @override
  Future<void> verifyCode({required String code, required bool isPhoneFlow}) {
    return _remoteDataSource.verifyCode(code: code, isPhoneFlow: isPhoneFlow);
  }

  @override
  Stream<UserProfile?> watchCurrentUser() async* {
    final current = await _remoteDataSource.getCurrentUser();
    yield current?.toEntity();
  }
}
