enum AppEnvironment { development, staging, production }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.baseApiUrl,
    required this.webSocketUrl,
    required this.neonDatabaseUrl,
    this.sentryDsn,
  });

  final AppEnvironment environment;
  final Uri baseApiUrl;
  final Uri webSocketUrl;
  final Uri neonDatabaseUrl;
  final String? sentryDsn;

  static AppConfig debug() => AppConfig(
        environment: AppEnvironment.development,
        baseApiUrl: Uri.parse('https://api.dev.nexachat.ai'),
        webSocketUrl: Uri.parse('wss://api.dev.nexachat.ai/ws'),
        neonDatabaseUrl: Uri.parse('postgresql://dev.neon.tech/nexachat'),
        sentryDsn: null,
      );

  static AppConfig staging() => AppConfig(
        environment: AppEnvironment.staging,
        baseApiUrl: Uri.parse('https://api.staging.nexachat.ai'),
        webSocketUrl: Uri.parse('wss://api.staging.nexachat.ai/ws'),
        neonDatabaseUrl: Uri.parse('postgresql://staging.neon.tech/nexachat'),
        sentryDsn: null,
      );

  static AppConfig production() => AppConfig(
        environment: AppEnvironment.production,
        baseApiUrl: Uri.parse('https://api.nexachat.ai'),
        webSocketUrl: Uri.parse('wss://api.nexachat.ai/ws'),
        neonDatabaseUrl: Uri.parse('postgresql://prod.neon.tech/nexachat'),
        sentryDsn: 'https://public@sentry.io/nexachat',
      );
}
