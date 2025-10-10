import '../../../models/payment_method_model.dart';

import '../../../network/api_endpoints.dart';
import '../nexa_api_client.dart';
import '../payment_remote_datasource.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl(this._client);

  final NexaApiClient _client;

  @override
  Future<PaymentMethodModel> addPaymentMethod({
    required String cardNumber,
    required String holderName,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    bool setDefault = false,
  }) async {
    final payload = await _client.postJson(
      ApiEndpoints.paymentMethods,
      data: {
        'card_number': cardNumber,
        'holder_name': holderName,
        'expiry_month': expiryMonth,
        'expiry_year': expiryYear,
        'cvv': cvv,
        'set_default': setDefault,
      },
    );
    return PaymentMethodModel.fromJson(payload);
  }

  @override
  Future<List<PaymentMethodModel>> fetchPaymentMethods() async {
    final payload = await _client.getJsonList(ApiEndpoints.paymentMethods);
    return payload.map((json) => PaymentMethodModel.fromJson(json)).toList();
  }

  @override
  Future<void> removePaymentMethod(String id) {
    return _client.deleteVoid(ApiEndpoints.paymentMethod(id));
  }

  @override
  Future<void> setDefaultPaymentMethod(String id) {
    return _client.postVoid(ApiEndpoints.paymentMethodDefault(id));
  }
}
