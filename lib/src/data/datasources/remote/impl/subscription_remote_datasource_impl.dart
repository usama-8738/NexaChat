import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../../network/api_endpoints.dart';
import '../nexa_api_client.dart';

import '../../../models/subscription_model.dart';
import '../../../models/subscription_plan_model.dart';
import '../subscription_remote_datasource.dart';

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  SubscriptionRemoteDataSourceImpl(this._client);

  final NexaApiClient _client;

  @override
  Future<void> cancelSubscription() async {
    try {
      await _client.deleteVoid(ApiEndpoints.currentSubscription);
    } on ServerException catch (error) {
      AppLogger.warn('Cancel subscription failed: ${error.message}');
      rethrow;
    }
  }

  @override
  Future<SubscriptionModel?> fetchCurrentSubscription() async {
    try {
      final response = await _client.getJson(ApiEndpoints.currentSubscription);
      if (response.isEmpty) {
        return null;
      }
      if (response['subscription'] == null) {
        return null;
      }
      return SubscriptionModel.fromJson(response['subscription'] as Map<String, dynamic>);
    } on ServerException catch (error) {
      if (error.statusCode == 404) {
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<List<SubscriptionPlanModel>> fetchPlans() async {
    final payload = await _client.getJsonList(ApiEndpoints.plans);
    return payload.map((json) => SubscriptionPlanModel.fromJson(json)).toList();
  }

  @override
  Future<void> subscribeToPlan(String planId) async {
    await _client.postVoid(
      ApiEndpoints.subscriptions,
      data: {'plan_id': planId},
    );
  }
}
