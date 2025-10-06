import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';

import '../../local/session_store.dart';
import '../../../models/user_profile_model.dart';
import '../../../network/api_endpoints.dart';
import '../nexa_api_client.dart';
import '../auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client, this._sessionStore);

  final NexaApiClient _client;
  final SessionStore _sessionStore;

  @override
  Future<UserProfileModel?> getCurrentUser() async {
    final response = await _client.getJson(ApiEndpoints.me);
    final user = response['user'] as Map<String, dynamic>?;
    if (user == null) {
      return null;
    }
    return UserProfileModel.fromJson(user);
  }

  @override
  Future<UserProfileModel> login({required String email, required String password}) async {
    final payload = await _client.postJson(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    await _persistSession(payload);
    return UserProfileModel.fromJson(_extractUser(payload));
  }

  @override
  Future<UserProfileModel> loginWithProvider({
    required String provider,
    required String accessToken,
  }) async {
    final payload = await _client.postJson(
      ApiEndpoints.loginOauthProvider(provider),
      data: {'access_token': accessToken},
    );
    await _persistSession(payload);
    return UserProfileModel.fromJson(_extractUser(payload));
  }

  @override
  Future<UserProfileModel> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final payload = await _client.postJson(
      ApiEndpoints.register,
      data: {
        'email': email,
        'password': password,
        'full_name': fullName,
      },
    );
    await _persistSession(payload);
    return UserProfileModel.fromJson(_extractUser(payload));
  }

  @override
  Future<void> logout() async {
    try {
      await _client.postVoid(ApiEndpoints.logout);
    } catch (error) {
      AppLogger.warn('Logout endpoint failed: $error');
    }
    await _sessionStore.clear();
  }

  @override
  Future<void> requestPasswordReset({required String email}) => _client.postVoid(
        ApiEndpoints.passwordResetRequest,
        data: {'email': email},
      );

  @override
  Future<void> resetPassword({required String token, required String newPassword}) => _client.postVoid(
        ApiEndpoints.passwordReset,
        data: {
          'token': token,
          'password': newPassword,
        },
      );

  @override
  Future<void> verifyCode({required String code, required bool isPhoneFlow}) => _client.postVoid(
        ApiEndpoints.verifyCode,
        data: {
          'code': code,
          'channel': isPhoneFlow ? 'sms' : 'email',
        },
      );

  @override
  Future<UserProfileModel?> refreshSession() async {
    final refreshToken = await _sessionStore.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }
    final payload = await _client.postJson(
      ApiEndpoints.refresh,
      data: {'refresh_token': refreshToken},
    );
    await _persistSession(payload);
    if (!payload.containsKey('user')) {
      return null;
    }
    return UserProfileModel.fromJson(_extractUser(payload));
  }

  Future<void> _persistSession(Map<String, dynamic> payload) async {
    final tokens = payload['tokens'] as Map<String, dynamic>?;
    if (tokens == null) {
      AppLogger.warn('Login response missing tokens');
      throw ServerException('Missing session tokens');
    }
    final access = tokens['access'] as String?;
    if (access == null || access.isEmpty) {
      throw ServerException('Missing access token');
    }
    final refresh = tokens['refresh'] as String?;
    await _sessionStore.saveTokens(accessToken: access, refreshToken: refresh);

    final user = payload['user'] as Map<String, dynamic>?;
    final userId = user?['id'] as String?;
    if (userId != null) {
      await _sessionStore.saveUserId(userId);
    }
  }

  Map<String, dynamic> _extractUser(Map<String, dynamic> payload) {
    final user = payload['user'] as Map<String, dynamic>?;
    if (user == null) {
      throw ServerException('Missing user payload');
    }
    return user;
  }
}
