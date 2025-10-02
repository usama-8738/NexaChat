import '../../domain/entities/payment_method.dart';

class PaymentMethodModel {
  const PaymentMethodModel({
    required this.id,
    required this.maskedNumber,
    required this.brand,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
  });

  final String id;
  final String maskedNumber;
  final String brand;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      maskedNumber: json['maskedNumber'] as String,
      brand: json['brand'] as String? ?? 'VISA',
      expiryMonth: json['expiryMonth'] as int,
      expiryYear: json['expiryYear'] as int,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  PaymentMethod toEntity() => PaymentMethod(
        id: id,
        maskedNumber: maskedNumber,
        brand: brand,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        isDefault: isDefault,
      );
}
