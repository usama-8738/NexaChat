import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.benefits,
    required this.isRecommended,
  });

  final String id;
  final String name;
  final double price;
  final String currency;
  final List<String> benefits;
  final bool isRecommended;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      benefits: (json['benefits'] as List<dynamic>? ?? const [])
          .map((item) => item as String)
          .toList(),
      isRecommended: json['isRecommended'] as bool? ?? false,
    );
  }

  SubscriptionPlan toEntity() => SubscriptionPlan(
        id: id,
        name: name,
        price: price,
        currency: currency,
        benefits: benefits,
        isRecommended: isRecommended,
      );
}
