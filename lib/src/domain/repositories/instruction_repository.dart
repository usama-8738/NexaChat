import '../entities/instruction_set.dart';

abstract class InstructionRepository {
  Future<List<InstructionSet>> fetchInstructions({required String assistantId});
  Future<void> saveInstructionSet({
    required String assistantId,
    required InstructionSet set,
  });
}
