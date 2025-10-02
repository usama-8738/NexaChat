import 'message.dart';

class Conversation {
  const Conversation({
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
  final List<Message> messages;
  final DateTime updatedAt;
  final DateTime? createdAt;

  Conversation copyWith({
    String? id,
    String? assistantId,
    String? title,
    List<Message>? messages,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      assistantId: assistantId ?? this.assistantId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
