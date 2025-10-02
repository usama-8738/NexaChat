import '../entities/instruction_set.dart';
import '../repositories/instruction_repository.dart';

class SaveInstructionSet {
  const SaveInstructionSet(this._repository);

  final InstructionRepository _repository;

  Future<void> call({required String assistantId, required InstructionSet set}) {
    return _repository.saveInstructionSet(assistantId: assistantId, set: set);
  }
}
