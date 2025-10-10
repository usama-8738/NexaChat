import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/payment_method.dart';
import '../../../domain/usecases/add_payment_method.dart';
import '../../../domain/usecases/get_payment_methods.dart';
import '../../../domain/usecases/remove_payment_method.dart';
import '../../../domain/usecases/set_default_payment_method.dart';
import 'payment_methods_state.dart';

class PaymentMethodsNotifier extends StateNotifier<PaymentMethodsState> {
  PaymentMethodsNotifier({
    required GetPaymentMethods getMethods,
    required AddPaymentMethod addMethod,
    required RemovePaymentMethod removeMethod,
    required SetDefaultPaymentMethod setDefaultMethod,
  })  : _getMethods = getMethods,
        _addMethod = addMethod,
        _removeMethod = removeMethod,
        _setDefaultMethod = setDefaultMethod,
        super(PaymentMethodsState.initial()) {
    loadMethods();
  }

  final GetPaymentMethods _getMethods;
  final AddPaymentMethod _addMethod;
  final RemovePaymentMethod _removeMethod;
  final SetDefaultPaymentMethod _setDefaultMethod;

  Future<void> loadMethods() async {
    state = state.copyWith(isLoading: true, resetFailure: true);
    try {
      final methods = await _getMethods();
      state = state.copyWith(isLoading: false, methods: methods, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(isLoading: false, failure: _mapError(error, stackTrace));
    }
  }

  Future<void> addPaymentMethod({
    required String cardNumber,
    required String holderName,
    required int expiryMonth,
    required int expiryYear,
    required String cvv,
    bool setDefault = false,
  }) async {
    state = state.copyWith(isProcessing: true, isAdding: true, pendingMethodId: null, resetFailure: true);
    try {
      final method = await _addMethod(
        cardNumber: cardNumber,
        holderName: holderName,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvv,
        setDefault: setDefault,
      );
      List<PaymentMethod> updated;
      if (setDefault) {
        updated = [
          for (final m in state.methods)
            PaymentMethod(
              id: m.id,
              maskedNumber: m.maskedNumber,
              brand: m.brand,
              expiryMonth: m.expiryMonth,
              expiryYear: m.expiryYear,
              isDefault: false,
            ),
        ];
        updated.add(
          PaymentMethod(
            id: method.id,
            maskedNumber: method.maskedNumber,
            brand: method.brand,
            expiryMonth: method.expiryMonth,
            expiryYear: method.expiryYear,
            isDefault: true,
          ),
        );
      } else {
        updated = List<PaymentMethod>.from(state.methods)..add(method);
      }
      state = state.copyWith(methods: updated, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
      rethrow;
    } finally {
      state = state.copyWith(isProcessing: false, isAdding: false);
    }
  }

  Future<void> removePaymentMethod(String id) async {
    state = state.copyWith(isProcessing: true, pendingMethodId: id, resetFailure: true);
    try {
      await _removeMethod(id);
      final updated = state.methods.where((method) => method.id != id).toList();
      state = state.copyWith(methods: updated, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
    } finally {
      state = state.copyWith(isProcessing: false, pendingMethodId: null);
    }
  }

  Future<void> setDefault(String id) async {
    state = state.copyWith(isProcessing: true, pendingMethodId: id, resetFailure: true);
    try {
      await _setDefaultMethod(id);
      final updated = state.methods
          .map((method) => PaymentMethod(
                id: method.id,
                maskedNumber: method.maskedNumber,
                brand: method.brand,
                expiryMonth: method.expiryMonth,
                expiryYear: method.expiryYear,
                isDefault: method.id == id,
              ))
          .toList();
      state = state.copyWith(methods: updated, resetFailure: true);
    } catch (error, stackTrace) {
      state = state.copyWith(failure: _mapError(error, stackTrace));
    } finally {
      state = state.copyWith(isProcessing: false, pendingMethodId: null);
    }
  }

  Failure _mapError(Object error, StackTrace stackTrace) {
    if (error is Failure) {
      return error;
    }
    return UnknownFailure(error.toString(), cause: stackTrace);
  }
}
