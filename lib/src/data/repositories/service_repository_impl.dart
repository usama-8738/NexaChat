import '../../domain/entities/service_offering.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/remote/service_remote_datasource.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  ServiceRepositoryImpl(this._remoteDataSource);

  final ServiceRemoteDataSource _remoteDataSource;

  @override
  Future<List<ServiceOffering>> fetchServices() async {
    final models = await _remoteDataSource.fetchServices();
    return models.map((model) => model.toEntity()).toList();
  }
}
