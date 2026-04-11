// =============================================================================
// main_stage.dart — Staging environment entrypoint
// =============================================================================
// Staging API base URL and logging flags. Run with Android flavor `stage`:
// flutter run --flavor stage -t lib/main_stage.dart
// =============================================================================

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/flavor.dart';

/// **Stage flavor**
///
/// - Android: `flutter run --flavor stage -t lib/main_stage.dart`
/// - iOS: `com.yourorg.doctorbridge.stage` (example bundle id)
Future<void> main() async {
  await bootstrap();
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(
            flavor: Flavor.stage,
            baseUrl: 'https://api-stage.doctorbridge.invalid',
            enableNetworkLogging: true,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
