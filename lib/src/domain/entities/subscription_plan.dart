class SubscriptionPlan {
  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.benefits,
    this.isRecommended = false,
  });

  final String id;
  final String name;
  final double price;
  final String currency;
  final List<String> benefits;
  final bool isRecommended;
}
