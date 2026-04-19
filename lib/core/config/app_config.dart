// =============================================================================
// app_config.dart — Per-environment API and feature flags
// =============================================================================
// [AppConfig] holds baseUrl and logging. [appConfigProvider] must be
// overridden in main() via ProviderScope (see main_*.dart). Features should
// use ref.watch(appConfigProvider) instead of literals. See docs/riverpod.md.
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'flavor.dart';

part 'app_config.g.dart';

/// Environment and API configuration. Never hard-code URLs in features;
/// read [AppConfig] from [appConfigProvider] (overridden at app start).
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.enableNetworkLogging,
  });

  final Flavor flavor;
  final String baseUrl;
  final bool enableNetworkLogging;

  String get environmentName => flavor.name;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) {
  throw StateError(
    'appConfigProvider must be overridden via ProviderScope '
    '(see main_dev.dart / main_stage.dart / main_prod.dart).',
  );
}
