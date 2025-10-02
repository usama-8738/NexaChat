import '../../models/chatbot_model.dart';
import '../../models/instruction_set_model.dart';

abstract class ChatbotRemoteDataSource {
  Future<List<ChatbotModel>> fetchAssistants();
  Future<ChatbotModel> getAssistant(String id);
  Future<List<InstructionSetModel>> fetchInstructionSets(String assistantId);
  Future<void> saveInstructionSet({
    required String assistantId,
    required InstructionSetModel instructions,
  });
}
