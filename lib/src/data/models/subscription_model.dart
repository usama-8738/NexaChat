import '../../domain/entities/subscription.dart';
import 'subscription_plan_model.dart';

class SubscriptionModel {
  const SubscriptionModel({
    required this.plan,
    required this.status,
    required this.creditsRemaining,
    required this.renewsAt,
  });

  final SubscriptionPlanModel plan;
  final String status;
  final int creditsRemaining;
  final DateTime? renewsAt;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      plan: SubscriptionPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
      status: json['status'] as String? ?? 'active',
      creditsRemaining: json['credits_remaining'] as int? ?? 0,
      renewsAt: json['renews_at'] != null ? DateTime.tryParse(json['renews_at'] as String) : null,
    );
  }

  Subscription toEntity() {
    final normalized = status.toLowerCase();
    final subscriptionStatus = SubscriptionStatus.values.firstWhere(
      (value) => value.name == normalized,
      orElse: () => SubscriptionStatus.active,
    );

    return Subscription(
      plan: plan.toEntity(),
      status: subscriptionStatus,
      creditsRemaining: creditsRemaining,
      renewsAt: renewsAt,
    );
  }
}
