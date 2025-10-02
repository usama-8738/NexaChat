import '../entities/payment_method.dart';
import '../repositories/payment_repository.dart';

class AddPaymentMethod {
  const AddPaymentMethod(this._repository);

  final PaymentRepository _repository;

  Future<PaymentMethod> call({
    required String cardNumber,
    required String holderName,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
  }) {
    return _repository.addPaymentMethod(
      cardNumber: cardNumber,
      holderName: holderName,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvv: cvv,
    );
  }
}
