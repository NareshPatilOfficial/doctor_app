// =============================================================================
// app_page_scaffold.dart — Authenticated shell with role drawer (stubs)
// =============================================================================
// Drawer items live under shared/widgets/app_drawer/roles/<role>/. Logout uses
// [SessionController.logout]. Patient role triggers [PatientAccountController
// .restoreFromColdStorage] once per scaffold mount. See docs/go-router.md.
// =============================================================================

import 'dart:async' show unawaited;

import 'package:doctorbridge_mobile_ui/core/auth/auth_state.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_account_controller.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/app_role_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Placeholder page for feature stubs: app bar, optional [body], and **role drawer**
/// when the session is authenticated.
class AppPageScaffold extends ConsumerStatefulWidget {
  const AppPageScaffold({
    required this.title,
    this.body,
    super.key,
  });

  final String title;

  /// Defaults to a centered [Text] of [title].
  final Widget? body;

  @override
  ConsumerState<AppPageScaffold> createState() => _AppPageScaffoldState();
}

class _AppPageScaffoldState extends ConsumerState<AppPageScaffold> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = ref.read(sessionControllerProvider).value;
      session?.maybeWhen(
        authenticated: (user) {
          if (user.role == UserRole.patient) {
            unawaited(
              ref.read(patientAccountControllerProvider.notifier).restoreFromColdStorage(),
            );
          }
        },
        orElse: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionControllerProvider);

    return session.when(
      data: (AuthState auth) {
        return auth.when(
          authenticated: (user) {
            return Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              drawer: AppRoleDrawer(user: user),
              body: widget.body ?? Center(child: Text(widget.title)),
            );
          },
          unauthenticated: () => Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: const Center(child: Text('Sign in required')),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
