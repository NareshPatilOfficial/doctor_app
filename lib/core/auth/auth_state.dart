// =============================================================================
// auth_state.dart — Session state for routing and UI (Freezed)
// =============================================================================
// Either unauthenticated or authenticated([User]). Exposed as AsyncValue via
// [sessionControllerProvider]. See docs/riverpod.md.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated(User user) = _Authenticated;
}
