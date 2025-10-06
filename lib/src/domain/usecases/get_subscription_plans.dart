﻿import '../entities/subscription_plan.dart';
import '../repositories/subscription_repository.dart';

class GetSubscriptionPlans {
  const GetSubscriptionPlans(this._repository);

  final SubscriptionRepository _repository;

  Future<List<SubscriptionPlan>> call() => _repository.fetchPlans();
}
