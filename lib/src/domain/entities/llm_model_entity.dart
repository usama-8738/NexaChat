class LlmModelEntity {
  const LlmModelEntity({
    required this.id,
    required this.name,
    required this.provider,
    required this.contextWindow,
    required this.temperature,
    required this.isPremium,
    this.description,
  });

  final String id;
  final String name;
  final String provider;
  final int contextWindow;
  final double temperature;
  final bool isPremium;
  final String? description;
}
