import '../entities/chatbot.dart';
import '../repositories/chatbot_repository.dart';

class SwitchModel {
  const SwitchModel(this._repository);

  final ChatbotRepository _repository;

  // TODO(ai): Gate premium assistants behind active subscription tiers before switching.
  Future<void> call(String assistantId) => _repository.setActiveAssistant(assistantId);

  Stream<Chatbot?> watchActive() => _repository.watchActiveAssistant();
}

