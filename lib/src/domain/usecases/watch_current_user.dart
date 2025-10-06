import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class WatchCurrentUser {
  const WatchCurrentUser(this._repository);

  final AuthRepository _repository;

  Stream<UserProfile?> call() => _repository.watchCurrentUser();
}
