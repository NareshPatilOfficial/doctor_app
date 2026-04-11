// =============================================================================
// widget_test.dart — Smoke test: app mounts with overridden AppConfig
// =============================================================================
// Demonstrates ProviderScope overrides for tests. See docs/riverpod.md.
// =============================================================================

import 'package:doctorbridge_mobile_ui/app/app.dart';
import 'package:doctorbridge_mobile_ui/core/config/app_config.dart';
import 'package:doctorbridge_mobile_ui/core/config/flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots to splash', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              flavor: Flavor.dev,
              baseUrl: 'https://example.test',
              enableNetworkLogging: false,
            ),
          ),
        ],
        child: const App(),
      ),
    );
    await tester.pump();
    expect(find.text('DoctorBridge'), findsOneWidget);
  });
}
