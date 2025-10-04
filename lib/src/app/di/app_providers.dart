import "package:connectivity_plus/connectivity_plus.dart";
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import '../../config/app_config.dart';
import '../../core/network/network_info.dart';
import '../../core/utils/logger.dart';
import '../../data/datasources/local/secure_store.dart';
import '../../data/datasources/local/session_store.dart';
import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/datasources/remote/impl/auth_remote_datasource_impl.dart';
import '../../data/datasources/remote/nexa_api_client.dart';
import '../../data/local/cache_database.dart';
import '../../data/network/auth_interceptor.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../services/analytics/analytics_service.dart';
import '../../services/monitoring/error_reporting_service.dart';
import '../../services/notifications/push_notification_service.dart';
import '../../services/storage/cloud_storage_service.dart';

final appConfigProvider = Provider<AppConfig>((_) => AppConfig.debug());

final connectivityProvider = Provider<Connectivity>((_) => Connectivity());

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return ConnectivityNetworkInfo(connectivity);
});

final secureStoreProvider = Provider<SecureStore>((_) => SecureStore());

final sessionStoreProvider = Provider<SessionStore>((ref) {
  final secureStore = ref.watch(secureStoreProvider);
  return SessionStore(secureStore);
});

final cacheDatabaseProvider = Provider<CacheDatabase>((_) => CacheDatabase());

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final sessionStore = ref.watch(sessionStoreProvider);
  return AuthInterceptor(sessionStore);
});

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final options = NexaApiClient.defaultOptions(config.baseApiUrl);
  final dio = Dio(options);
  dio.interceptors.add(ref.watch(authInterceptorProvider));
  dio.interceptors.add(
    LogInterceptor(
      requestBody: false,
      responseBody: false,
      logPrint: (object) => AppLogger.debug(object.toString()),
    ),
  );
  return dio;
});

final apiClientProvider = Provider<NexaApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return NexaApiClient(dio);
});

final analyticsServiceProvider = Provider<AnalyticsService>((_) => const NoopAnalyticsService());

final errorReportingServiceProvider = Provider<ErrorReportingService>((_) => const NoopErrorReportingService());

final pushNotificationServiceProvider = Provider<PushNotificationService>((_) => const NoopPushNotificationService());

final cloudStorageServiceProvider = Provider<CloudStorageService>((_) => const NoopCloudStorageService());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final client = ref.watch(apiClientProvider);
  final sessionStore = ref.watch(sessionStoreProvider);
  return AuthRemoteDataSourceImpl(client, sessionStore);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remote);
});
