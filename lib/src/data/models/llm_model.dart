class LlmModel {
  const LlmModel({
    required this.id,
    required this.displayName,
    required this.provider,
    required this.contextWindow,
    required this.defaultTemperature,
    this.description,
    this.isPremium = false,
  });

  final String id;
  final String displayName;
  final String provider;
  final int contextWindow;
  final double defaultTemperature;
  final String? description;
  final bool isPremium;

  factory LlmModel.fromJson(Map<String, dynamic> json) => LlmModel(
        id: json['id'] as String,
        displayName: json['display_name'] as String,
        provider: json['provider'] as String,
        contextWindow: json['context_window'] as int,
        defaultTemperature: (json['default_temperature'] as num).toDouble(),
        description: json['description'] as String?,
        isPremium: json['is_premium'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'display_name': displayName,
        'provider': provider,
        'context_window': contextWindow,
        'default_temperature': defaultTemperature,
        'description': description,
        'is_premium': isPremium,
      };
}
