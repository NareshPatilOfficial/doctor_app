// =============================================================================
// main_prod.dart — Production entrypoint
// =============================================================================
// Production [AppConfig]: logging off, mock auth off. Use with flavor `prod`.
// flutter run --flavor prod -t lib/main_prod.dart
// =============================================================================

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/config/flavor.dart';

/// **Production flavor**
///
/// - Android: `flutter run --flavor prod -t lib/main_prod.dart`
/// - iOS: `com.yourorg.doctorbridge` (example release bundle id)
/// - Set [AppConfig.enableNetworkLogging] to false and [enableMockAuth] false for
///   store builds once real auth ships.
Future<void> main() async {
  await bootstrap();
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(
            flavor: Flavor.prod,
            baseUrl: 'https://api.doctorbridge.invalid',
            enableNetworkLogging: false,
            enableMockAuth: false,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
