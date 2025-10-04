import '../../models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserProfileModel> login({required String email, required String password});
  Future<UserProfileModel> register({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> requestPasswordReset({required String email});
  Future<void> resetPassword({required String token, required String newPassword});
  Future<void> verifyCode({required String code, required bool isPhoneFlow});
  Future<UserProfileModel?> getCurrentUser();
  Future<void> logout();
}
