import 'package:flutter_test/flutter_test.dart';

import 'package:lib/src/app/app.dart';
import 'package:lib/src/config/app_config.dart';

void main() {
  testWidgets('App boots into splash screen', (tester) async {
    await tester.pumpWidget(NexaChatApp(config: AppConfig.debug()));

    await tester.pumpAndSettle();

    expect(find.text('Splash Screen Placeholder'), findsOneWidget);
  });
}
