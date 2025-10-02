import '../../domain/entities/chatbot.dart';
import '../../domain/entities/instruction_set.dart';
import '../../domain/repositories/chatbot_repository.dart';
import '../datasources/remote/chatbot_remote_datasource.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  ChatbotRepositoryImpl(this._remoteDataSource);

  final ChatbotRemoteDataSource _remoteDataSource;

  @override
  Future<List<Chatbot>> fetchAssistants() async {
    final models = await _remoteDataSource.fetchAssistants();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Chatbot> getAssistant(String id) async {
    final model = await _remoteDataSource.getAssistant(id);
    return model.toEntity();
  }

  @override
  Future<List<InstructionSet>> fetchInstructionSets(String assistantId) async {
    final models = await _remoteDataSource.fetchInstructionSets(assistantId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateInstructionSet({
    required String assistantId,
    required InstructionSet instructions,
  }) {
    throw UnimplementedError();
  }
}
