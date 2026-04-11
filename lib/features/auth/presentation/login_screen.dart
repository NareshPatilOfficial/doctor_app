// =============================================================================
// login_screen.dart — Sign-in (mock role picker until API auth exists)
// =============================================================================
// Calls [SessionController.loginMock] when [AppConfig.enableMockAuth] is true.
// Replace with real credentials + token exchange in production.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/session_controller.dart';
import '../../../core/auth/user.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Mock sign-in selects a role. Replace with real auth when the API is ready.',
          ),
          const SizedBox(height: 24),
          for (final role in UserRole.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FilledButton(
                onPressed: () => ref.read(sessionControllerProvider.notifier).loginMock(role),
                child: Text('Continue as ${role.name}'),
              ),
            ),
        ],
      ),
    );
  }
}
