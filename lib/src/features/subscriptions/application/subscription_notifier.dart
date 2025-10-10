import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/usecases/cancel_subscription.dart';
import '../../../domain/usecases/get_current_subscription.dart';
import '../../../domain/usecases/get_subscription_plans.dart';
import '../../../domain/usecases/subscribe_to_plan.dart';
import 'subscription_state.dart';

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  SubscriptionNotifier({
    required GetSubscriptionPlans getPlans,
    required GetCurrentSubscription getCurrent,
    required SubscribeToPlan subscribeToPlan,
    required CancelSubscription cancelSubscription,
  })  : _getPlans = getPlans,
        _getCurrent = getCurrent,
        _subscribeToPlan = subscribeToPlan,
        _cancelSubscription = cancelSubscription,
        super(SubscriptionState.initial()) {
    _bootstrap();
  }

  final GetSubscriptionPlans _getPlans;
  final GetCurrentSubscription _getCurrent;
  final SubscribeToPlan _subscribeToPlan;
  final CancelSubscription _cancelSubscription;

  Future<void> _bootstrap() async {
    await loadPlans();
    await refreshSubscription();
  }

  Future<void> loadPlans() async {
    state = state.copyWith(isLoading: true, resetFailure: true);
    try {
      final plans = await _getPlans();
      state = state.copyWith(isLoading: false, plans: plans, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(isLoading: false, failure: _mapError(error, stackTrace));
    }
  }

  Future<void> refreshSubscription() async {
    try {
      final subscription = await _getCurrent();
      state = state.copyWith(current: subscription, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
    }
  }

  Future<void> subscribe(String planId) async {
    state = state.copyWith(
      isProcessing: true,
      pendingPlanId: planId,
      isCancelling: false,
      resetFailure: true,
    );
    try {
      await _subscribeToPlan(planId);
      await refreshSubscription();
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
    } finally {
      state = state.copyWith(isProcessing: false, pendingPlanId: null);
    }
  }

  Future<void> cancel() async {
    state = state.copyWith(
      isProcessing: true,
      pendingPlanId: null,
      isCancelling: true,
      resetFailure: true,
    );
    try {
      await _cancelSubscription();
      await refreshSubscription();
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
    } finally {
      state = state.copyWith(isProcessing: false, isCancelling: false);
    }
  }

  Failure _mapError(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      return error;
    }
    return UnknownFailure(error.toString(), cause: stackTrace);
  }
}
