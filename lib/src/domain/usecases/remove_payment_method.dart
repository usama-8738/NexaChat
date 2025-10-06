import '../repositories/payment_repository.dart';

class RemovePaymentMethod {
  const RemovePaymentMethod(this._repository);

  final PaymentRepository _repository;

  Future<void> call(String id) => _repository.removePaymentMethod(id);
}
