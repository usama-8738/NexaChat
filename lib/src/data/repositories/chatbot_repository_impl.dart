import 'dart:async';

import '../../domain/entities/chatbot.dart';
import '../../domain/entities/instruction_set.dart';
import '../../domain/repositories/chatbot_repository.dart';
import '../datasources/remote/chatbot_remote_datasource.dart';
import '../models/instruction_set_model.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  ChatbotRepositoryImpl(this._remoteDataSource);

  final ChatbotRemoteDataSource _remoteDataSource;
  final StreamController<Chatbot?> _activeAssistantController = StreamController<Chatbot?>.broadcast();
  Chatbot? _activeAssistant;

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
  Future<void> saveInstructionSet({
    required String assistantId,
    required InstructionSet instructions,
  }) async {
    // TODO(ai): Push updated guardrails/instructions upstream once persistence layer is ready.
    final model = InstructionSetModel.fromEntity(instructions);
    await _remoteDataSource.saveInstructionSet(assistantId: assistantId, instructions: model);
  }

  @override
  Future<void> setActiveAssistant(String assistantId) async {
    final assistant = await getAssistant(assistantId);
    _activeAssistant = assistant;
    _activeAssistantController.add(assistant);
  }

  @override
  Stream<Chatbot?> watchActiveAssistant() async* {
    yield _activeAssistant;
    yield* _activeAssistantController.stream;
  }
}
