import '../../models/service_offering_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceOfferingModel>> fetchServices();
}
