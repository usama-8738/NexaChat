import '../../models/subscription_plan_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionPlanModel>> fetchPlans();
  Future<void> subscribeToPlan(String planId);
  Future<void> cancelSubscription();
}
