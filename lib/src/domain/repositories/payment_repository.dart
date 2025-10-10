import '../entities/payment_method.dart';

abstract class PaymentRepository {
  Future<List<PaymentMethod>> fetchPaymentMethods();
  Future<PaymentMethod> addPaymentMethod({
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
