import 'package:doctorbridge_mobile_ui/core/async/async_tracker.dart';
import 'package:doctorbridge_mobile_ui/core/auth/auth_state.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/token_storage.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/auth/auth_user_merge.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/models/auth_api_models.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_account_state.dart';
import 'package:doctorbridge_mobile_ui/features/patient/application/patient_operation_ids.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/models/user_profile_dto.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/users_repository.dart';
import 'package:doctorbridge_mobile_ui/features/patient/data/users_repository_providers.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_account_controller.g.dart';

@Riverpod(keepAlive: true)
class PatientAccountController extends _$PatientAccountController {
  @override
  PatientAccountState build() {
    ref.listen(sessionControllerProvider, (previous, next) {
      next.whenData((AuthState auth) {
        auth.when(
          unauthenticated: () {
            state = const PatientAccountState.inactive();
          },
          authenticated: (_) {},
        );
      });
    });
    return const PatientAccountState.inactive();
  }

  /// After login: [AuthNotifier] may pass [preloadedProfile] from GET `/api/v1/users/{id}`.
  Future<void> hydrateAfterLogin(
    AuthLoginPayload payload, {
    UserProfileDto? preloadedProfile,
  }) async {
    if (payload.user.role != UserRole.patient) {
      state = const PatientAccountState.inactive();
      return;
    }
    final linked = payload.resolvedLinkedUserIds;
    if (linked.isEmpty) {
      state = const PatientAccountState.inactive();
      return;
    }
    final active = linked.first;
    if (preloadedProfile != null) {
      state = PatientAccountState.ready(
        linkedUserIds: linked,
        activeUserId: active,
        profile: preloadedProfile,
      );
      return;
    }
    state = const PatientAccountState.loading();
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = PatientOperationIds.hydrateProfile;
    tracker.start(op);
    try {
      final profile = await ref.read(usersRepositoryProvider).getUser(active);
      await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
            accessToken: payload.jwtToken,
            user: userFromProfileDto(profile, roleOverride: UserRole.patient),
          );
      state = PatientAccountState.ready(
        linkedUserIds: linked,
        activeUserId: active,
        profile: profile,
      );
      tracker.fulfill(op);
    } on Object catch (e) {
      tracker.reportError(
        op,
        e is UsersRepositoryException ? e.message : 'Could not load your profile',
      );
      state = const PatientAccountState.inactive();
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }

  /// Cold start / navigation: load profile when storage has linked patient ids.
  Future<void> restoreFromColdStorage() async {
    final session = ref.read(sessionControllerProvider).value;
    if (session == null) {
      return;
    }
    final user = session.when(
      unauthenticated: () => null,
      authenticated: (u) => u,
    );
    if (user == null || user.role != UserRole.patient) {
      return;
    }
    final stored = await ref.read(tokenStorageProvider).readPatientLinkedAccounts();
    if (stored == null) {
      return;
    }
    final activeId = stored.activeUserId;
    final current = state;
    final already = current.maybeWhen(
      ready: (linked, active, profile) =>
          active == activeId && listEquals(linked, stored.userIds),
      orElse: () => false,
    );
    if (already) {
      return;
    }
    state = const PatientAccountState.loading();
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = PatientOperationIds.hydrateProfile;
    tracker.start(op);
    try {
      final token = await ref.read(tokenStorageProvider).readAccessToken();
      if (token == null || token.isEmpty) {
        state = const PatientAccountState.inactive();
        return;
      }
      final profile = await ref.read(usersRepositoryProvider).getUser(activeId);
      await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
            accessToken: token,
            user: userFromProfileDto(profile, roleOverride: UserRole.patient),
          );
      state = PatientAccountState.ready(
        linkedUserIds: stored.userIds,
        activeUserId: activeId,
        profile: profile,
      );
      tracker.fulfill(op);
    } on Object catch (e) {
      tracker.reportError(
        op,
        e is UsersRepositoryException ? e.message : 'Could not restore profile',
      );
      state = const PatientAccountState.inactive();
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }

  Future<void> switchToUserId(int userId) async {
    final linked = state.maybeWhen(
      ready: (l, a, p) => l,
      orElse: () => null,
    );
    if (linked == null || !linked.contains(userId)) {
      throw StateError('Invalid patient selection');
    }
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = PatientOperationIds.switchActiveUser;
    tracker.start(op);
    try {
      final profile = await ref.read(usersRepositoryProvider).getUser(userId);
      final token = await ref.read(tokenStorageProvider).readAccessToken();
      if (token == null || token.isEmpty) {
        throw UsersRepositoryException('Session expired');
      }
      await ref.read(tokenStorageProvider).persistPatientLinkedAccounts(
            userIds: linked,
            activeUserId: userId,
          );
      await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
            accessToken: token,
            user: userFromProfileDto(profile, roleOverride: UserRole.patient),
          );
      state = PatientAccountState.ready(
        linkedUserIds: linked,
        activeUserId: userId,
        profile: profile,
      );
      tracker.fulfill(op);
    } on Object catch (e) {
      tracker.reportError(
        op,
        e is UsersRepositoryException ? e.message : 'Could not switch user',
      );
      rethrow;
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }
}
