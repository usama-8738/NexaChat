import '../../domain/entities/instruction_set.dart';

class InstructionSetModel {
  const InstructionSetModel({
    required this.id,
    required this.title,
    required this.steps,
    required this.category,
  });

  final String id;
  final String title;
  final List<String> steps;
  final String? category;

  factory InstructionSetModel.fromJson(Map<String, dynamic> json) {
    return InstructionSetModel(
      id: json['id'] as String,
      title: json['title'] as String,
      steps: (json['steps'] as List<dynamic>? ?? const [])
          .map((item) => item as String)
          .toList(),
      category: json['category'] as String?,
    );
  }

  InstructionSet toEntity() => InstructionSet(
        id: id,
        title: title,
        steps: steps,
        category: category,
      );
}
