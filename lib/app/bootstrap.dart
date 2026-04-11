// =============================================================================
// bootstrap.dart — One-time async startup before runApp
// =============================================================================
// Call from every main_*.dart after [WidgetsFlutterBinding.ensureInitialized].
// Add Firebase, error handlers, or native channel warm-up here later.
// Flavor / platform notes: see comments below and ARCHITECTURE.md.
// =============================================================================

import 'package:flutter/widgets.dart';

/// Async startup: Firebase, runtime config, etc.
///
/// **Android flavors:** `dev`, `stage`, `prod` product flavors are defined in
/// `android/app/build.gradle.kts`. Run with:
/// `flutter run --flavor dev -t lib/main_dev.dart`
///
/// **iOS schemes:** Create Xcode schemes `dev`, `stage`, `prod` that pass
/// `--flavor` / target entrypoint (see `ARCHITECTURE.md`). Use distinct
/// bundle identifiers per environment when distributing builds.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
}
