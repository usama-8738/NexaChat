import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  const RegisterUser(this._repository);

  final AuthRepository _repository;

  Future<UserProfile> call({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _repository.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
