class ApiConstants {
  const ApiConstants._();

  static const Duration defaultConnectTimeout = Duration(seconds: 20);
  static const Duration defaultReceiveTimeout = Duration(seconds: 30);
  static const String tenantHeader = 'X-Nexa-Tenant';
  static const String apiVersionHeader = 'X-Nexa-Version';

  static const String restBasePath = '/v1';
  static const String authBasePath = '/auth';
  static const String chatBasePath = '/chat';
  static const String billingBasePath = '/billing';
}
