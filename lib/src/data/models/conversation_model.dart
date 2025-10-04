import 'message_model.dart';

class ConversationModel {
  const ConversationModel({
    required this.id,
    required this.assistantId,
    required this.title,
    required this.messages,
    required this.updatedAt,
    this.createdAt,
  });

  final String id;
  final String assistantId;
  final String title;
  final List<MessageModel> messages;
  final DateTime updatedAt;
  final DateTime? createdAt;

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
        id: json['id'] as String,
        assistantId: json['assistant_id'] as String,
        title: json['title'] as String,
        messages: (json['messages'] as List<dynamic>? ?? [])
            .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        createdAt:
            json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'assistant_id': assistantId,
        'title': title,
        'messages': messages.map((e) => e.toJson()).toList(),
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
      };
}
