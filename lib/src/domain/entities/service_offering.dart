class ServiceOffering {
  const ServiceOffering({
    required this.id,
    required this.title,
    required this.summary,
    required this.associatedAssistantId,
  });

  final String id;
  final String title;
  final String summary;
  final String associatedAssistantId;
}
