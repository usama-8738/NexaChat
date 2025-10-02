class InstructionSet {
  const InstructionSet({
    required this.id,
    required this.title,
    required this.steps,
    this.category,
  });

  final String id;
  final String title;
  final List<String> steps;
  final String? category;
}
