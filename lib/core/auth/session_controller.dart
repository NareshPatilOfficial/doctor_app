// =============================================================================
// session_controller.dart — Auth session AsyncNotifier
// =============================================================================
// Loads token + user from [TokenStorage] on startup; [loginMock] for dev;
// [logout] / [logoutOnUnauthorized] clear storage and update state. Router and
// Dio 401 handler depend on this. See docs/riverpod.md.
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import 'auth_state.dart';
import 'token_storage.dart';
import 'user.dart';

part 'session_controller.g.dart';

@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
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
    return AuthState.authenticated(user);
  }

  Future<void> loginMock(UserRole role) async {
    final config = ref.read(appConfigProvider);
    if (!config.enableMockAuth) {
      return;
    }
    final user = User(
      id: 'mock-user',
      displayName: 'Mock ${role.name}',
      role: role,
    );
    await ref.read(tokenStorageProvider).persistSession(
          accessToken: 'mock-access-token',
          refreshToken: null,
          user: user,
        );
    state = AsyncData(AuthState.authenticated(user));
  }

  Future<void> logout() async {
    await ref.read(tokenStorageProvider).clearSession();
    state = const AsyncData(AuthState.unauthenticated());
  }

  /// Called from the Dio stack when the API returns 401.
  Future<void> logoutOnUnauthorized() => logout();
}
