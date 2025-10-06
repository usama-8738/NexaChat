import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class RefreshSession {
  const RefreshSession(this._repository);

  final AuthRepository _repository;

  Future<UserProfile?> call() => _repository.refreshSession();
}
