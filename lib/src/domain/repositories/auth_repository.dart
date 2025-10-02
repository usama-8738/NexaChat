import '../entities/user_profile.dart';

abstract class AuthRepository {
  Future<UserProfile> login({required String email, required String password});
  Future<UserProfile> register({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> requestPasswordReset({required String email});
  Future<void> resetPassword({required String token, required String newPassword});
  Future<void> verifyCode({required String code, required bool isPhoneFlow});
  Stream<UserProfile?> watchCurrentUser();
  Future<void> logout();
}
