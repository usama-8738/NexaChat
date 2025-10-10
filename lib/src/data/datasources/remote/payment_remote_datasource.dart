import '../../models/payment_method_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentMethodModel>> fetchPaymentMethods();
  Future<PaymentMethodModel> addPaymentMethod({
    required String cardNumber,
    required String holderName,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    bool setDefault = false,
  });
  Future<void> removePaymentMethod(String id);
  Future<void> setDefaultPaymentMethod(String id);
}
