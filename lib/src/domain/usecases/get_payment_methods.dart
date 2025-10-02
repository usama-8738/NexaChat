import '../entities/payment_method.dart';
import '../repositories/payment_repository.dart';

class GetPaymentMethods {
  const GetPaymentMethods(this._repository);

  final PaymentRepository _repository;

  Future<List<PaymentMethod>> call() {
    return _repository.fetchPaymentMethods();
  }
}
