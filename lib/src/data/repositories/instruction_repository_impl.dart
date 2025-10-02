import '../../domain/entities/instruction_set.dart';
import '../../domain/repositories/instruction_repository.dart';
import '../datasources/remote/chatbot_remote_datasource.dart';
import '../models/instruction_set_model.dart';

class InstructionRepositoryImpl implements InstructionRepository {
  InstructionRepositoryImpl(this._remoteDataSource);

  final ChatbotRemoteDataSource _remoteDataSource;

  @override
  Future<List<InstructionSet>> fetchInstructions({required String assistantId}) async {
    final models = await _remoteDataSource.fetchInstructionSets(assistantId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveInstructionSet({
    required String assistantId,
    required InstructionSet set,
  }) {
    final model = InstructionSetModel(
      id: set.id,
      title: set.title,
      steps: set.steps,
      category: set.category,
    );
    return _remoteDataSource.saveInstructionSet(
      assistantId: assistantId,
      instructions: model,
    );
  }
}
