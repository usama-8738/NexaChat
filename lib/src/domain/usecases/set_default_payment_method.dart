import '../repositories/payment_repository.dart';

class SetDefaultPaymentMethod {
  const SetDefaultPaymentMethod(this._repository);

  final PaymentRepository _repository;

  Future<void> call(String id) => _repository.setDefaultPaymentMethod(id);
}
