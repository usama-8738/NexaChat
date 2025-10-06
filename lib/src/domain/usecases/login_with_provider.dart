import '../entities/user_profile.dart';
import '../entities/oauth_provider.dart';
import '../repositories/auth_repository.dart';

class LoginWithProvider {
  const LoginWithProvider(this._repository);

  final AuthRepository _repository;

  Future<UserProfile> call({
    required OAuthProvider provider,
    required String accessToken,
  }) {
    return _repository.loginWithProvider(provider: provider, accessToken: accessToken);
  }
}
