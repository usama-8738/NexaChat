abstract class AnalyticsService {
  const AnalyticsService();

  Future<void> initialize();
  Future<void> trackEvent(String name, {Map<String, Object?> properties});
  Future<void> setUserId(String userId);
  Future<void> setUserProperties(Map<String, Object?> properties);
}

class NoopAnalyticsService extends AnalyticsService {
  const NoopAnalyticsService();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> setUserId(String userId) async {}

  @override
  Future<void> setUserProperties(Map<String, Object?> properties) async {}

  @override
  Future<void> trackEvent(String name, {Map<String, Object?> properties = const {}}) async {}
}
