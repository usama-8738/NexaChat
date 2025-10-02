import '../../domain/entities/chatbot.dart';

class ChatbotModel {
  const ChatbotModel({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarAsset,
    required this.capabilities,
  });

  final String id;
  final String name;
  final String description;
  final String avatarAsset;
  final List<String> capabilities;

  factory ChatbotModel.fromJson(Map<String, dynamic> json) {
    return ChatbotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      avatarAsset: json['avatarAsset'] as String? ?? '',
      capabilities: (json['capabilities'] as List<dynamic>? ?? const [])
          .map((item) => item as String)
          .toList(),
    );
  }

  Chatbot toEntity() => Chatbot(
        id: id,
        name: name,
        description: description,
        avatarAsset: avatarAsset,
        capabilities: capabilities,
      );
}
