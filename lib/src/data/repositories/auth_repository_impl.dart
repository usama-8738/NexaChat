import 'dart:async';

import '../../domain/entities/oauth_provider.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final StreamController<UserProfile?> _userController = StreamController<UserProfile?>.broadcast();

  @override
  Future<UserProfile> login({required String email, required String password}) async {
    final model = await _remoteDataSource.login(email: email, password: password);
    final user = model.toEntity();
    _userController.add(user);
    return user;
  }

  @override
  Future<UserProfile> loginWithProvider({
    required OAuthProvider provider,
    required String accessToken,
  }) async {
    final model = await _remoteDataSource.loginWithProvider(
      provider: provider.name,
      accessToken: accessToken,
    );
    final user = model.toEntity();
    _userController.add(user);
    return user;
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
    final user = model.toEntity();
    _userController.add(user);
    return user;
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
    yield* _userController.stream;
  }

  @override
  Future<UserProfile?> refreshSession() async {
    final model = await _remoteDataSource.refreshSession();
    final user = model?.toEntity();
    _userController.add(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
    _userController.add(null);
  }
}
