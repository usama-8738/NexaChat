import 'secure_store.dart';

class SessionStore {
  SessionStore(this._secureStore);

  final SecureStore _secureStore;

  static const _accessTokenKey = 'session.access';
  static const _refreshTokenKey = 'session.refresh';
  static const _userIdKey = 'session.userId';

  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    await _secureStore.write(_accessTokenKey, accessToken);
    if (refreshToken != null) {
      await _secureStore.write(_refreshTokenKey, refreshToken);
    }
  }

  Future<String?> readAccessToken() => _secureStore.read(_accessTokenKey);

  Future<String?> readRefreshToken() => _secureStore.read(_refreshTokenKey);

  Future<void> clearTokens() async {
    await _secureStore.delete(_accessTokenKey);
    await _secureStore.delete(_refreshTokenKey);
  }

  Future<void> saveUserId(String userId) => _secureStore.write(_userIdKey, userId);

  Future<String?> readUserId() => _secureStore.read(_userIdKey);

  Future<void> clear() async {
    await _secureStore.delete(_accessTokenKey);
    await _secureStore.delete(_refreshTokenKey);
    await _secureStore.delete(_userIdKey);
  }
}
