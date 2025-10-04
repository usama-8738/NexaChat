import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";

import '../../config/app_config.dart';
import '../../core/utils/logger.dart';
import '../../data/local/cache_database.dart';

Future<void> initializeApp(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final cacheDatabase = CacheDatabase();
  await cacheDatabase.openCoreBoxes();
  // TODO(data): Bootstrap local caches (Drift/Hive boxes) once schema is defined.

  AppLogger.info('Bootstrapping ${config.environment} environment');
}

// TODO(platform): Establish Neon/PostgreSQL migrations via backend service during app start.
