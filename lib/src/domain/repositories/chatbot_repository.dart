import '../entities/chatbot.dart';
import '../entities/instruction_set.dart';

abstract class ChatbotRepository {
  Future<List<Chatbot>> fetchAssistants();
  Future<Chatbot> getAssistant(String id);
  Future<List<InstructionSet>> fetchInstructionSets(String assistantId);
  Future<void> saveInstructionSet({
    required String assistantId,
    required InstructionSet instructions,
  });
  Future<void> setActiveAssistant(String assistantId);
  Stream<Chatbot?> watchActiveAssistant();
}
