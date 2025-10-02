import '../entities/chatbot.dart';
import '../repositories/chatbot_repository.dart';

class GetChatbots {
  const GetChatbots(this._repository);

  final ChatbotRepository _repository;

  Future<List<Chatbot>> call() {
    return _repository.fetchAssistants();
  }
}
