import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/payment_method.dart';

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    required this.isLoading,
    required this.isProcessing,
    required this.methods,
    this.failure,
    this.pendingMethodId,
    this.isAdding = false,
  });

  factory PaymentMethodsState.initial() => const PaymentMethodsState(
        isLoading: false,
        isProcessing: false,
        methods: <PaymentMethod>[],
      );

  final bool isLoading;
  final bool isProcessing;
  final List<PaymentMethod> methods;
  final Failure? failure;
  final String? pendingMethodId;
  final bool isAdding;

  PaymentMethod? get defaultMethod {
    for (final method in methods) {
      if (method.isDefault) {
        return method;
      }
    }
    return methods.isNotEmpty ? methods.first : null;
  }

  PaymentMethodsState copyWith({
    bool? isLoading,
    bool? isProcessing,
    List<PaymentMethod>? methods,
    Failure? failure,
    bool resetFailure = false,
    String? pendingMethodId,
    bool? isAdding,
  }) {
    return PaymentMethodsState(
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      methods: methods ?? this.methods,
      failure: resetFailure ? null : (failure ?? this.failure),
      pendingMethodId: pendingMethodId ?? this.pendingMethodId,
      isAdding: isAdding ?? this.isAdding,
    );
  }

  @override
  List<Object?> get props => [isLoading, isProcessing, methods, failure, pendingMethodId, isAdding];
}
