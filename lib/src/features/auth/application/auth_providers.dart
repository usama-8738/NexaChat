import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/app_providers.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/login_with_provider.dart';
import '../../../domain/usecases/logout_user.dart';
import '../../../domain/usecases/register_user.dart';
import '../../../domain/usecases/request_password_reset.dart';
import '../../../domain/usecases/refresh_session.dart';
import '../../../domain/usecases/reset_password.dart';
import '../../../domain/usecases/verify_code.dart';
import '../../../domain/usecases/watch_current_user.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

final loginUserProvider = Provider<LoginUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUser(repository);
});

final loginWithProviderProvider = Provider<LoginWithProvider>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginWithProvider(repository);
});

final registerUserProvider = Provider<RegisterUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUser(repository);
});

final logoutUserProvider = Provider<LogoutUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUser(repository);
});

final requestPasswordResetProvider = Provider<RequestPasswordReset>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RequestPasswordReset(repository);
});

final verifyCodeProvider = Provider<VerifyCode>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return VerifyCode(repository);
});

final refreshSessionProvider = Provider<RefreshSession>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshSession(repository);
});

final resetPasswordProvider = Provider<ResetPassword>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ResetPassword(repository);
});

final watchCurrentUserProvider = Provider<WatchCurrentUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return WatchCurrentUser(repository);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUser: ref.watch(loginUserProvider),
    loginWithProvider: ref.watch(loginWithProviderProvider),
    registerUser: ref.watch(registerUserProvider),
    logoutUser: ref.watch(logoutUserProvider),
    requestPasswordReset: ref.watch(requestPasswordResetProvider),
    verifyCode: ref.watch(verifyCodeProvider),
    refreshSession: ref.watch(refreshSessionProvider),
    resetPassword: ref.watch(resetPasswordProvider),
    watchCurrentUser: ref.watch(watchCurrentUserProvider),
  );
});