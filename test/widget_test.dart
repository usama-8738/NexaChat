import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lib/src/app/app.dart';
import 'package:lib/src/app/di/app_providers.dart';
import 'package:lib/src/config/app_config.dart';

void main() {
  testWidgets('App boots into splash screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appConfigProvider.overrideWithValue(AppConfig.debug())],
        child: const NexaChatApp(),
      ),
    );

    await tester.pump();

    expect(find.text('NexaChat'), findsOneWidget);
    expect(
      find.text('Multi-modal AI copilots for every workflow.'),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 2000));
  });
}
