// =============================================================================
// splash_screen.dart — Initial loading UI while session restores
// =============================================================================
// Shown during [sessionControllerProvider] loading; router redirects when ready.
// =============================================================================

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(size: 72),
            SizedBox(height: 24),
            Text('DoctorBridge'),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
