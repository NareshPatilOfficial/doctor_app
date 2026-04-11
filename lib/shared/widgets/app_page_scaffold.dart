// =============================================================================
// app_page_scaffold.dart — Simple placeholder UI for feature stubs
// =============================================================================
// Used by role/feature screens until real designs are implemented. Replace with
// product widgets per feature under features/<name>/presentation/.
// =============================================================================

import 'package:flutter/material.dart';

/// Minimal placeholder page used while feature UIs are built out.
class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
