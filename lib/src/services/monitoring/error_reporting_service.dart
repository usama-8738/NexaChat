abstract class ErrorReportingService {
  const ErrorReportingService();

  Future<void> initialize();
  Future<void> report(dynamic error, {StackTrace? stackTrace, Map<String, Object?>? context});
}

class NoopErrorReportingService extends ErrorReportingService {
  const NoopErrorReportingService();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> report(dynamic error, {StackTrace? stackTrace, Map<String, Object?>? context}) async {}
}
