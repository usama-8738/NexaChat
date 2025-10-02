import '../entities/service_offering.dart';

abstract class ServiceRepository {
  Future<List<ServiceOffering>> fetchServices();
}
