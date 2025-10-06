import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  const LoginUser(this._repository);

  final AuthRepository _repository;

  Future<UserProfile> call(String email, String password) {
    return _repository.login(email: email, password: password);
  }
}
