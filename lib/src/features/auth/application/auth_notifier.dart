import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/oauth_provider.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/login_with_provider.dart';
import '../../../domain/usecases/logout_user.dart';
import '../../../domain/usecases/register_user.dart';
import '../../../domain/usecases/request_password_reset.dart';
import '../../../domain/usecases/refresh_session.dart';
import '../../../domain/usecases/reset_password.dart';
import '../../../domain/usecases/verify_code.dart';
import '../../../domain/usecases/watch_current_user.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required LoginUser loginUser,
    required LoginWithProvider loginWithProvider,
    required RegisterUser registerUser,
    required LogoutUser logoutUser,
    required RequestPasswordReset requestPasswordReset,
    required VerifyCode verifyCode,
    required RefreshSession refreshSession,
    required ResetPassword resetPassword,
    required WatchCurrentUser watchCurrentUser,
  })  : _loginUser = loginUser,
        _loginWithProvider = loginWithProvider,
        _registerUser = registerUser,
        _logoutUser = logoutUser,
        _requestPasswordReset = requestPasswordReset,
        _verifyCode = verifyCode,
        _refreshSession = refreshSession,
        _resetPassword = resetPassword,
        _watchCurrentUser = watchCurrentUser,
        super(const AuthUnauthenticated()) {
    _userSubscription = _watchCurrentUser().listen((user) {
      if (user != null) {
        state = AuthAuthenticated(user);
      } else if (state is! AuthLoading) {
        state = const AuthUnauthenticated();
      }
    });

    Future.microtask(() async {
      try {
        final user = await _refreshSession();
        if (user != null) {
          _onAuthenticated(user);
        }
      } catch (error, stackTrace) {
        final failure = _mapError(error, stackTrace);
        state = AuthFailureState(failure);
      }
    });
  }

  final LoginUser _loginUser;
  final LoginWithProvider _loginWithProvider;
  final RegisterUser _registerUser;
  final LogoutUser _logoutUser;
  final RequestPasswordReset _requestPasswordReset;
  final VerifyCode _verifyCode;
  final RefreshSession _refreshSession;
  final ResetPassword _resetPassword;
  final WatchCurrentUser _watchCurrentUser;

  StreamSubscription<UserProfile?>? _userSubscription;

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  Future<void> login(String email, String password) async {
    state = const AuthLoading();
    try {
      final user = await _loginUser(email, password);
      _onAuthenticated(user);
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> loginWithSocial(OAuthProvider provider, String accessToken) async {
    state = const AuthLoading();
    try {
      final user = await _loginWithProvider(provider: provider, accessToken: accessToken);
      _onAuthenticated(user);
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = const AuthLoading();
    try {
      final user = await _registerUser(
        email: email,
        password: password,
        fullName: fullName,
      );
      _onAuthenticated(user);
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> requestReset(String email) async {
    state = const AuthLoading();
    try {
      await _requestPasswordReset(email);
      state = const AuthUnauthenticated();
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> verify({required String code, required bool isPhoneFlow}) async {
    state = const AuthLoading();
    try {
      await _verifyCode(code: code, isPhoneFlow: isPhoneFlow);
      state = const AuthUnauthenticated();
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    state = const AuthLoading();
    try {
      await _resetPassword(token: token, newPassword: newPassword);
      state = const AuthUnauthenticated();
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> sendPhoneCode(String phoneNumber) async {
    state = const AuthLoading();
    try {
      // TODO(auth): Integrate SMS OTP dispatch via backend provider.
      await Future.delayed(const Duration(milliseconds: 600));
      state = const AuthUnauthenticated();
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> restoreSession() async {
    try {
      final user = await _refreshSession();
      if (user != null) {
        _onAuthenticated(user);
      }
    } catch (error, stackTrace) {
      final failure = _mapError(error, stackTrace);
      state = AuthFailureState(failure);
      throw failure;
    }
  }

  Future<void> logout() async {
    await _logoutUser();
    state = const AuthUnauthenticated();
  }

  Failure _mapError(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      return error;
    }
    return UnknownFailure(error.toString(), cause: stackTrace);
  }

  void _onAuthenticated(UserProfile user) {
    state = AuthAuthenticated(user);
  }
}