import 'subscription_plan.dart';

class Subscription {
  const Subscription({
    required this.plan,
    required this.renewsAt,
    required this.status,
    required this.creditsRemaining,
  });

  final SubscriptionPlan plan;
  final DateTime? renewsAt;
  final SubscriptionStatus status;
  final int creditsRemaining;
}

enum SubscriptionStatus { active, pastDue, canceled, expired }
