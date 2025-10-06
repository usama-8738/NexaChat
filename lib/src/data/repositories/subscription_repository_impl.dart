import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_plan.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/remote/subscription_remote_datasource.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._remoteDataSource);

  final SubscriptionRemoteDataSource _remoteDataSource;

  @override
  Future<void> cancelSubscription() {
    return _remoteDataSource.cancelSubscription();
  }

  @override
  Future<Subscription?> fetchCurrentSubscription() async {
    final model = await _remoteDataSource.fetchCurrentSubscription();
    return model?.toEntity();
  }

  @override
  Future<List<SubscriptionPlan>> fetchPlans() async {
    final models = await _remoteDataSource.fetchPlans();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> subscribeToPlan({required String planId}) {
    return _remoteDataSource.subscribeToPlan(planId);
  }
}
