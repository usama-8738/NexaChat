import 'package:flutter/material.dart';

import '../config/app_config.dart';
import 'app.dart';

Future<void> bootstrap({AppConfig? config}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final resolvedConfig = config ?? AppConfig.debug();

  runApp(NexaChatApp(config: resolvedConfig));
}
