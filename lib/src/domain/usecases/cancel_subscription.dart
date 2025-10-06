import '../repositories/subscription_repository.dart';

class CancelSubscription {
  const CancelSubscription(this._repository);

  final SubscriptionRepository _repository;

  Future<void> call() => _repository.cancelSubscription();
}
