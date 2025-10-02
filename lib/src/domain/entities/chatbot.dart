class Chatbot {
  const Chatbot({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarAsset,
    required this.capabilities,
  });

  final String id;
  final String name;
  final String description;
  final String avatarAsset;
  final List<String> capabilities;
}
