class PaymentMethod {
  const PaymentMethod({
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
}
