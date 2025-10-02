enum AppEnvironment { development, staging, production }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.baseApiUrl,
  });

  final AppEnvironment environment;
  final Uri baseApiUrl;

  static AppConfig debug() => AppConfig(
        environment: AppEnvironment.development,
        baseApiUrl: Uri.parse('https://api.dev.nexachat.ai'),
      );

  static AppConfig production() => AppConfig(
        environment: AppEnvironment.production,
        baseApiUrl: Uri.parse('https://api.nexachat.ai'),
      );
}
