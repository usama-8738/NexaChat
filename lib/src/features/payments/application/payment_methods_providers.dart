import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/di/app_providers.dart';
import '../../../domain/usecases/add_payment_method.dart';
import '../../../domain/usecases/get_payment_methods.dart';
import '../../../domain/usecases/remove_payment_method.dart';
import '../../../domain/usecases/set_default_payment_method.dart';
import 'payment_methods_notifier.dart';
import 'payment_methods_state.dart';

final getPaymentMethodsProvider = Provider<GetPaymentMethods>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return GetPaymentMethods(repository);
});

final addPaymentMethodProvider = Provider<AddPaymentMethod>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return AddPaymentMethod(repository);
});

final removePaymentMethodProvider = Provider<RemovePaymentMethod>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return RemovePaymentMethod(repository);
});

final setDefaultPaymentMethodProvider = Provider<SetDefaultPaymentMethod>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return SetDefaultPaymentMethod(repository);
});

final paymentMethodsNotifierProvider = StateNotifierProvider<PaymentMethodsNotifier, PaymentMethodsState>((ref) {
  return PaymentMethodsNotifier(
    getMethods: ref.watch(getPaymentMethodsProvider),
    addMethod: ref.watch(addPaymentMethodProvider),
    removeMethod: ref.watch(removePaymentMethodProvider),
    setDefaultMethod: ref.watch(setDefaultPaymentMethodProvider),
  );
});
