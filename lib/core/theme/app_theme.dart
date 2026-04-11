// =============================================================================
// app_theme.dart — Global ThemeData (light theme)
// =============================================================================
// Consumed by [App]. Extend with dark theme or typography as the design system
// grows.
// =============================================================================

import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      useMaterial3: true,
    );
    return base.copyWith(
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}
