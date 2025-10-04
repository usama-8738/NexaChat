import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import 'app.dart';
import 'di/app_initializer.dart';
import 'di/app_providers.dart';

Future<void> bootstrap({AppConfig? config}) async {
  final resolvedConfig = config ?? AppConfig.debug();

  await initializeApp(resolvedConfig);

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(resolvedConfig),
      ],
      child: const NexaChatApp(),
    ),
  );
}
