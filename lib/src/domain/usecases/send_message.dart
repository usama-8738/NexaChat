import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessage {
  const SendMessage(this._repository);

  final ChatRepository _repository;

  Future<Message> call({
    required String conversationId,
    required Message message,
    required String assistantId,
  }) {
    // TODO(ai): Deduct credits and persist token usage before forwarding to repository.
    return _repository.sendMessage(
      conversationId: conversationId,
      message: message,
      assistantId: assistantId,
    );
  }
}

