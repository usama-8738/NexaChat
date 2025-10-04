import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../config/theme/app_theme.dart';
import 'di/app_providers.dart';
import 'router/app_router.dart';
import 'router/routes.dart';

class NexaChatApp extends ConsumerStatefulWidget {
  const NexaChatApp({super.key});

  @override
  ConsumerState<NexaChatApp> createState() => _NexaChatAppState();
}

class _NexaChatAppState extends ConsumerState<NexaChatApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = const AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appConfigProvider);

    return MaterialApp(
      title: config.environment == AppEnvironment.production ? 'NexaChat' : 'NexaChat (${config.environment.name})',
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: config.environment != AppEnvironment.production,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
