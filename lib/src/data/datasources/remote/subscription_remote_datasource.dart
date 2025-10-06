import '../../models/subscription_model.dart';
import '../../models/subscription_plan_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionPlanModel>> fetchPlans();
  Future<SubscriptionModel?> fetchCurrentSubscription();
  Future<void> subscribeToPlan(String planId);
  Future<void> cancelSubscription();
}
