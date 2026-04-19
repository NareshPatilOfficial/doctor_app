// =============================================================================
// app_page_scaffold.dart — Authenticated shell with role drawer (stubs)
// =============================================================================
// Drawer items live under shared/widgets/app_drawer/roles/<role>/. Logout uses
// [SessionController.logout] (clears session + async tracker); router sends
// users to login. See docs/go-router.md.
// =============================================================================

import 'package:doctorbridge_mobile_ui/core/auth/auth_state.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/app_role_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Placeholder page for feature stubs: app bar, optional [body], and **role drawer**
/// when the session is authenticated.
class AppPageScaffold extends ConsumerWidget {
  const AppPageScaffold({
    required this.title,
    this.body,
    super.key,
  });

  final String title;

  /// Defaults to a centered [Text] of [title].
  final Widget? body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);

    return session.when(
      data: (AuthState auth) {
        return auth.when(
          authenticated: (user) {
            return Scaffold(
              appBar: AppBar(title: Text(title)),
              drawer: AppRoleDrawer(user: user),
              body: body ?? Center(child: Text(title)),
            );
          },
          unauthenticated: () => Scaffold(
            appBar: AppBar(title: Text(title)),
            body: const Center(child: Text('Sign in required')),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
