import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/remote/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._remoteDataSource);

  final PaymentRemoteDataSource _remoteDataSource;

  @override
  Future<PaymentMethod> addPaymentMethod({
    required String cardNumber,
    required String holderName,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    bool setDefault = false,
  }) async {
    final model = await _remoteDataSource.addPaymentMethod(
      cardNumber: cardNumber,
      holderName: holderName,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvv: cvv,
      setDefault: setDefault,
    );
    return model.toEntity();
  }

  @override
  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    final models = await _remoteDataSource.fetchPaymentMethods();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> removePaymentMethod(String id) {
    return _remoteDataSource.removePaymentMethod(id);
  }

  @override
  Future<void> setDefaultPaymentMethod(String id) {
    return _remoteDataSource.setDefaultPaymentMethod(id);
  }
}
