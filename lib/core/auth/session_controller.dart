// =============================================================================
// session_controller.dart — Auth session AsyncNotifier
// =============================================================================
// Loads token + user from [TokenStorage] on startup;
// [logout] / [logoutOnUnauthorized] clear storage and update state. Router and
// Dio 401 handler depend on this. See docs/riverpod.md.
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_state.dart';
import 'token_storage.dart';
import 'user.dart';

part 'session_controller.g.dart';

@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  /// One-shot redirect after patient login (e.g. go_router [extra] without query).
  String? _pendingPostLoginPath;

  @override
  Future<AuthState> build() async {
    final storage = ref.read(tokenStorageProvider);
    final token = await storage.readAccessToken();
    if (token == null || token.isEmpty) {
      return const AuthState.unauthenticated();
    }
    final user = await storage.readUser();
    if (user == null) {
      await storage.clearSession();
      return const AuthState.unauthenticated();
    }
    // Optional: validate token with GET profile — add when API is wired.
    return AuthState.authenticated(user);
  }

  /// Set before login when [LoginLaunchExtra] provides a return path (no query).
  void setPendingPostLoginPath(String? path) {
    _pendingPostLoginPath = path;
  }

  /// Consumed by [routerProvider] redirect when leaving `/login` after auth.
  String? takePendingPostLoginPath() {
    final p = _pendingPostLoginPath;
    _pendingPostLoginPath = null;
    return p;
  }

  /// Persist JWT + user after successful API login (matches web localStorage + Redux).
  Future<void> applyAuthenticatedSession({
    required String accessToken,
    required User user,
  }) async {
    await ref.read(tokenStorageProvider).persistSession(
          accessToken: accessToken,
          refreshToken: null,
          user: user,
        );
    state = AsyncData(AuthState.authenticated(user));
  }

  Future<void> logout() async {
    _pendingPostLoginPath = null;
    await ref.read(tokenStorageProvider).clearSession();
    state = const AsyncData(AuthState.unauthenticated());
  }

  /// Called from the Dio stack when the API returns 401.
  Future<void> logoutOnUnauthorized() => logout();
}
