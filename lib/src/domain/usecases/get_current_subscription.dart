import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

class GetCurrentSubscription {
  const GetCurrentSubscription(this._repository);

  final SubscriptionRepository _repository;

  Future<Subscription?> call() => _repository.fetchCurrentSubscription();
}
