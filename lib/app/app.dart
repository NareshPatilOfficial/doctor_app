// =============================================================================
// app.dart — Root Material app widget
// =============================================================================
// Watches [routerProvider] and passes it to [MaterialApp.router]. Theme comes
// from [AppTheme]. All state lives under the [ProviderScope] created in main().
// See: docs/go-router.md
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'DoctorBridge',
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
