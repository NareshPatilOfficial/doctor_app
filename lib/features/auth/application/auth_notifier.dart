import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/auth_repository_providers.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/models/auth_api_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

/// Coordinates auth API calls and [SessionController] persistence.
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  void build() {}

  Future<AuthLoginPayload> loginWithPassword({
    required String phone10Digits,
    required String password,
    required UserRole role,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    final payload = await repo.loginWithPassword(
      phone10Digits: phone10Digits,
      password: password,
      role: role,
    );
    await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
          accessToken: payload.jwtToken,
          user: payload.user,
        );
    return payload;
  }

  Future<void> sendPatientOtp({required String phone10Digits}) async {
    await ref.read(authRepositoryProvider).sendOtp(phone10Digits: phone10Digits);
  }

  Future<AuthLoginPayload> patientLoginWithOtp({
    required String phone10Digits,
    required String otpCode,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    final payload = await repo.patientLoginWithOtp(
      phone10Digits: phone10Digits,
      otpCode: otpCode,
    );
    await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
          accessToken: payload.jwtToken,
          user: payload.user,
        );
    return payload;
  }
}
