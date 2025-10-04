abstract class CloudStorageService {
  const CloudStorageService();

  Future<void> uploadFile(String path, List<int> bytes, {Map<String, String>? metadata});
  Future<List<int>> downloadFile(String path);
  Future<void> deleteFile(String path);
}

class NoopCloudStorageService extends CloudStorageService {
  const NoopCloudStorageService();

  @override
  Future<void> deleteFile(String path) async {}

  @override
  Future<List<int>> downloadFile(String path) async => <int>[];

  @override
  Future<void> uploadFile(String path, List<int> bytes, {Map<String, String>? metadata}) async {}
}
