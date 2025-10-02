import '../entities/instruction_set.dart';
import '../repositories/instruction_repository.dart';

class GetInstructionSets {
  const GetInstructionSets(this._repository);

  final InstructionRepository _repository;

  Future<List<InstructionSet>> call(String assistantId) {
    return _repository.fetchInstructions(assistantId: assistantId);
  }
}
