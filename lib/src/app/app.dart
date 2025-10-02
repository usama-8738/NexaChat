import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../config/theme/app_theme.dart';
import 'router/app_router.dart';
import 'router/routes.dart';

class NexaChatApp extends StatefulWidget {
  const NexaChatApp({super.key, required this.config});

  final AppConfig config;

  @override
  State<NexaChatApp> createState() => _NexaChatAppState();
}

class _NexaChatAppState extends State<NexaChatApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = const AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NexaChat',
      theme: buildAppTheme(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
