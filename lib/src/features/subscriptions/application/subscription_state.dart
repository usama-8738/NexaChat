import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/subscription.dart';
import '../../../domain/entities/subscription_plan.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    required this.isLoading,
    required this.isProcessing,
    required this.plans,
    this.current,
    this.failure,
    this.pendingPlanId,
    this.isCancelling = false,
  });

  factory SubscriptionState.initial() => const SubscriptionState(
        isLoading: false,
        isProcessing: false,
        plans: <SubscriptionPlan>[],
      );

  final bool isLoading;
  final bool isProcessing;
  final List<SubscriptionPlan> plans;
  final Subscription? current;
  final Failure? failure;
  final String? pendingPlanId;
  final bool isCancelling;

  bool get hasActiveSubscription => current != null && current!.status == SubscriptionStatus.active;
  int get creditsRemaining => current?.creditsRemaining ?? 0;

  SubscriptionState copyWith({
    bool? isLoading,
    bool? isProcessing,
    List<SubscriptionPlan>? plans,
    Subscription? current,
    Failure? failure,
    String? pendingPlanId,
    bool? isCancelling,
    bool resetFailure = false,
  }) {
    return SubscriptionState(
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      plans: plans ?? this.plans,
      current: current ?? this.current,
      failure: resetFailure ? null : (failure ?? this.failure),
      pendingPlanId: pendingPlanId ?? this.pendingPlanId,
      isCancelling: isCancelling ?? this.isCancelling,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isProcessing,
        plans,
        current,
        failure,
        pendingPlanId,
        isCancelling,
      ];
}
