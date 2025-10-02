import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl();

  @override
  Future<Conversation> createConversation({required String assistantId, String? title}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteConversation(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Message> sendMessage({
    required String conversationId,
    required Message message,
    required String assistantId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> regenerateResponse({required String messageId}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Conversation>> watchConversations() {
    throw UnimplementedError();
  }
}
