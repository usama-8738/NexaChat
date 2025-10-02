import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Stream<List<Conversation>> watchConversations();
  Future<Conversation> createConversation({required String assistantId, String? title});
  Future<void> deleteConversation(String id);
  Future<Message> sendMessage({
    required String conversationId,
    required Message message,
    required String assistantId,
  });
  Future<void> regenerateResponse({required String messageId});
}
