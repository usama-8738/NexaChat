import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/app_providers.dart';
import '../../../domain/usecases/cancel_subscription.dart';
import '../../../domain/usecases/get_current_subscription.dart';
import '../../../domain/usecases/get_subscription_plans.dart';
import '../../../domain/usecases/subscribe_to_plan.dart';
import 'subscription_notifier.dart';
import 'subscription_state.dart';

final getSubscriptionPlansProvider = Provider<GetSubscriptionPlans>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return GetSubscriptionPlans(repository);
});

final getCurrentSubscriptionProvider = Provider<GetCurrentSubscription>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return GetCurrentSubscription(repository);
});

final subscribeToPlanProvider = Provider<SubscribeToPlan>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return SubscribeToPlan(repository);
});

final cancelSubscriptionProvider = Provider<CancelSubscription>((ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return CancelSubscription(repository);
});

final subscriptionNotifierProvider = StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  return SubscriptionNotifier(
    getPlans: ref.watch(getSubscriptionPlansProvider),
    getCurrent: ref.watch(getCurrentSubscriptionProvider),
    subscribeToPlan: ref.watch(subscribeToPlanProvider),
    cancelSubscription: ref.watch(cancelSubscriptionProvider),
  );
});
