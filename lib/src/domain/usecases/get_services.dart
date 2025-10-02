import '../entities/service_offering.dart';
import '../repositories/service_repository.dart';

class GetServices {
  const GetServices(this._repository);

  final ServiceRepository _repository;

  Future<List<ServiceOffering>> call() {
    return _repository.fetchServices();
  }
}
