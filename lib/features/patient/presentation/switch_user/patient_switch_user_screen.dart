import 'dart:async' show unawaited;

import 'package:doctorbridge_mobile_ui/core/async/async_selectors.dart';
import 'package:doctorbridge_mobile_ui/core/async/async_tracker.dart';
import 'package:doctorbridge_mobile_ui/core/auth/auth_state.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_account_controller.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_account_state.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_operation_ids.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/models/user_profile_dto.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/users_repository.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/users_repository_providers.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Lists linked patient accounts from login [userIds] and switches the active profile.
class PatientSwitchUserScreen extends ConsumerStatefulWidget {
  const PatientSwitchUserScreen({super.key});

  @override
  ConsumerState<PatientSwitchUserScreen> createState() => _PatientSwitchUserScreenState();
}

class _PatientSwitchUserScreenState extends ConsumerState<PatientSwitchUserScreen> {
  List<UserProfileDto>? _rows;
  Object? _loadError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_load()));
  }

  Future<void> _load() async {
    final account = ref.read(patientAccountControllerProvider);
    final linked = account.maybeWhen(
      ready: (List<int> ids, int active, UserProfileDto p) => ids,
      orElse: () => null,
    );
    if (linked == null || linked.isEmpty) {
      setState(() {
        _loadError = 'No linked accounts';
      });
      return;
    }
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = PatientOperationIds.listLinkedUsers;
    tracker.start(op);
    try {
      final list = await ref.read(usersRepositoryProvider).listUsersByIds(linked);
      tracker.fulfill(op);
      if (mounted) {
        setState(() {
          _rows = list;
          _loadError = null;
        });
      }
    } on Object catch (e) {
      tracker.reportError(
        op,
        e is UsersRepositoryException ? e.message : 'Could not load users',
      );
      if (mounted) {
        setState(() {
          _loadError = e is UsersRepositoryException ? e.message : 'Could not load users';
        });
      }
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }

  Future<void> _onSelect(UserProfileDto row) async {
    final id = row.id;
    try {
      await ref.read(patientAccountControllerProvider.notifier).switchToUserId(id);
    } on Object catch (e) {
      if (!mounted) {
        return;
      }
      final msg = e is UsersRepositoryException
          ? e.message
          : (e is StateError ? e.message : e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg.isNotEmpty ? msg : 'Could not switch user')),
      );
      return;
    }
    if (!mounted) {
      return;
    }
    // Do not treat navigation failures as a failed switch (switch already succeeded).
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionControllerProvider);
    final User? user = sessionAsync.when(
      data: (AuthState auth) => auth.when(
            unauthenticated: () => null,
            authenticated: (User u) => u,
          ),
      loading: () => null,
      error: (_, _) => null,
    );
    if (user == null || user.role != UserRole.patient) {
      return const AppPageScaffold(
        title: 'Switch user',
        body: Center(child: Text('Sign in as a patient to switch accounts.')),
      );
    }

    final account = ref.watch(patientAccountControllerProvider);
    final accountLoading = account.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (accountLoading) {
      return const AppPageScaffold(
        title: 'Switch user',
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final int? activeId = account.maybeWhen(
      ready: (List<int> l, int a, UserProfileDto p) => a,
      orElse: () => null,
    );

    final loading = ref.watch(asyncIsFetchingProvider(PatientOperationIds.listLinkedUsers));
    final listErr = ref.watch(asyncErrorProvider(PatientOperationIds.listLinkedUsers));

    return AppPageScaffold(
      title: 'Switch user',
      body: RefreshIndicator(
        onRefresh: _load,
        child: _buildBody(context, loading, listErr, activeId),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool loading,
    String? listErr,
    int? activeId,
  ) {
    if (_loadError != null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(_loadError.toString()),
          ),
        ],
      );
    }
    if (loading && _rows == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (listErr != null && (_rows == null || _rows!.isEmpty)) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(listErr),
          ),
        ],
      );
    }
    final rows = _rows ?? [];
    if (rows.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          Padding(
            padding: EdgeInsets.all(24),
            child: Text('No users found'),
          ),
        ],
      );
    }
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: rows.length,
      itemBuilder: (context, i) {
        final row = rows[i];
        final subtitle = row.phone ?? row.email ?? '';
        final selected = activeId != null && row.id == activeId;
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              row.displayName.isNotEmpty ? row.displayName[0].toUpperCase() : '?',
            ),
          ),
          title: Text(row.displayName),
          subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
          trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
          selected: selected,
          onTap: selected ? null : () => unawaited(_onSelect(row)),
        );
      },
    );
  }
}
