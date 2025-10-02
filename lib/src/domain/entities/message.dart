class Message {
  const Message({
    required this.id,
    required this.role,
    required this.content,
    required this.sentAt,
    this.metadata,
  });

  final String id;
  final MessageRole role;
  final String content;
  final DateTime sentAt;
  final Map<String, Object?>? metadata;

  Message copyWith({
    String? id,
    MessageRole? role,
    String? content,
    DateTime? sentAt,
    Map<String, Object?>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

enum MessageRole { user, assistant, system }
