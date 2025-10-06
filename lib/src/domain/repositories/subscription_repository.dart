import '../entities/subscription.dart';
import '../entities/subscription_plan.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionPlan>> fetchPlans();
  Future<Subscription?> fetchCurrentSubscription();
  Future<void> subscribeToPlan({required String planId});
  Future<void> cancelSubscription();
}
