import '../repositories/subscription_repository.dart';

class SubscribeToPlan {
  const SubscribeToPlan(this._repository);

  final SubscriptionRepository _repository;

  Future<void> call(String planId) => _repository.subscribeToPlan(planId: planId);
}
