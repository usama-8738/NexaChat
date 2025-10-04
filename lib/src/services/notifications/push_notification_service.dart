abstract class PushNotificationService {
  const PushNotificationService();

  Future<void> initialize();
  Future<String?> getDeviceToken();
  Future<void> requestPermission();
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
}

class NoopPushNotificationService extends PushNotificationService {
  const NoopPushNotificationService();

  @override
  Future<String?> getDeviceToken() async => null;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}
}
