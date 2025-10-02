import '../../domain/entities/service_offering.dart';

class ServiceOfferingModel {
  const ServiceOfferingModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.associatedAssistantId,
  });

  final String id;
  final String title;
  final String summary;
  final String associatedAssistantId;

  factory ServiceOfferingModel.fromJson(Map<String, dynamic> json) {
    return ServiceOfferingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      associatedAssistantId: json['assistantId'] as String,
    );
  }

  ServiceOffering toEntity() => ServiceOffering(
        id: id,
        title: title,
        summary: summary,
        associatedAssistantId: associatedAssistantId,
      );
}
