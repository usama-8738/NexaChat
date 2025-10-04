class MessageModel {
  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.author,
    required this.content,
    required this.createdAt,
    this.metadata,
  });

  final String id;
  final String conversationId;
  final String author;
  final String content;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'] as String,
        conversationId: json['conversation_id'] as String,
        author: json['author'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        metadata: (json['metadata'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversation_id': conversationId,
        'author': author,
        'content': content,
        'created_at': createdAt.toIso8601String(),
        'metadata': metadata,
      };
}
