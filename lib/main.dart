// =============================================================================
// main.dart — Default app entrypoint
// =============================================================================
// Runs async [bootstrap], then starts the widget tree with [ProviderScope].
// Injects dev [AppConfig] via [appConfigProvider.overrideWithValue] so features
// read API base URL and flags from Riverpod (never hard-code URLs elsewhere).
// For explicit flavors, use main_dev.dart / main_stage.dart / main_prod.dart.
// See: ARCHITECTURE.md, docs/riverpod.md
// =============================================================================

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/flavor.dart';

Future<void> main() async {
  await bootstrap();
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(
            flavor: Flavor.dev,
            baseUrl: 'https://api-dev.doctorbridge.invalid',
            enableNetworkLogging: true,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
