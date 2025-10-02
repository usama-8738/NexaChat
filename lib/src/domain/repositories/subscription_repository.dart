import '../entities/subscription_plan.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionPlan>> fetchPlans();
  Future<void> subscribeToPlan({required String planId});
  Future<void> cancelSubscription();
}
