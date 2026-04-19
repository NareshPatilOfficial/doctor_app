// =============================================================================
// main_dev.dart — Development flavor entrypoint
// =============================================================================
// Same as [main] but documents the dev pairing with Android product flavor
// `dev`. Use with: flutter run --flavor dev -t lib/main_dev.dart
// =============================================================================

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/flavor.dart';

/// **Dev flavor**
///
/// - Android: `flutter run --flavor dev -t lib/main_dev.dart`
/// - iOS: add a `dev` scheme with the same `-t lib/main_dev.dart` (and optional
///   `--flavor dev` when using Flutter flavor integration). Use a distinct bundle
///   id, e.g. `com.yourorg.doctorbridge.dev`.
Future<void> main() async {
  await bootstrap();
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(
            flavor: Flavor.dev,
            // Web uses `localhost` — the **Android emulator** cannot reach your PC
            // via `localhost` (that points at the emulator itself). Use the special
            // alias to the host machine: `http://10.0.2.2:PORT` (same as localhost on
            // your computer). iOS Simulator often works with `http://127.0.0.1:PORT`.
            // Production/stage: prefer HTTPS (no cleartext restrictions).
            baseUrl: 'http://10.0.2.2:3000',
            enableNetworkLogging: true,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
