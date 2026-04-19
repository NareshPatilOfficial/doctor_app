import 'package:doctorbridge_mobile_ui/core/async/async_tracker.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/auth_repository.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/auth_repository_providers.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/models/auth_api_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_operation_ids.dart';

part 'auth_notifier.g.dart';

/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).
///
/// In-flight calls are **coalesced** only when the request parameters match
/// (same Future for double-taps). A concurrent call with **different** inputs
/// throws [AuthRepositoryException] so callers never receive another user's result.
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  Future<AuthLoginPayload>? _inFlightPasswordLogin;
  int? _passwordLoginCoalesceKey;

  Future<void>? _inFlightSendOtp;
  String? _sendOtpCoalesceKey;

  Future<AuthLoginPayload>? _inFlightPatientOtpLogin;
  int? _patientOtpCoalesceKey;

  @override
  void build() {}

  Future<AuthLoginPayload> loginWithPassword({
    required String phone10Digits,
    required String password,
    required UserRole role,
  }) async {
    final key = Object.hash(phone10Digits, role, password);
    if (_inFlightPasswordLogin != null) {
      if (_passwordLoginCoalesceKey == key) {
        return _inFlightPasswordLogin!;
      }
      const msg = 'Please wait for the current sign-in to finish.';
      ref.read(asyncTrackerProvider.notifier).reportError(AuthOperationIds.loginWithPassword, msg);
      throw AuthRepositoryException(msg);
    }
    _passwordLoginCoalesceKey = key;
    return _inFlightPasswordLogin = _loginWithPasswordBody(
      phone10Digits: phone10Digits,
      password: password,
      role: role,
    ).whenComplete(() {
      _inFlightPasswordLogin = null;
      _passwordLoginCoalesceKey = null;
    });
  }

  Future<AuthLoginPayload> _loginWithPasswordBody({
    required String phone10Digits,
    required String password,
    required UserRole role,
  }) async {
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = AuthOperationIds.loginWithPassword;
    tracker.start(op);
    try {
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
      tracker.fulfill(op);
      return payload;
    } on AuthRepositoryException catch (e) {
      tracker.reportError(op, e.message);
      rethrow;
    } on Object catch (_) {
      tracker.reportError(op, AuthRepository.genericLoginError);
      rethrow;
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }

  Future<void> sendPatientOtp({required String phone10Digits}) async {
    if (_inFlightSendOtp != null) {
      if (_sendOtpCoalesceKey == phone10Digits) {
        return _inFlightSendOtp!;
      }
      const msg = 'Please wait for the current request to finish.';
      ref.read(asyncTrackerProvider.notifier).reportError(AuthOperationIds.sendPatientOtp, msg);
      throw AuthRepositoryException(msg);
    }
    _sendOtpCoalesceKey = phone10Digits;
    return _inFlightSendOtp = _sendPatientOtpBody(phone10Digits: phone10Digits).whenComplete(() {
      _inFlightSendOtp = null;
      _sendOtpCoalesceKey = null;
    });
  }

  Future<void> _sendPatientOtpBody({required String phone10Digits}) async {
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = AuthOperationIds.sendPatientOtp;
    tracker.start(op);
    try {
      await ref.read(authRepositoryProvider).sendOtp(phone10Digits: phone10Digits);
      tracker.fulfill(op);
    } on AuthRepositoryException catch (e) {
      tracker.reportError(op, e.message);
      rethrow;
    } on Object catch (_) {
      tracker.reportError(op, 'Invalid phone number');
      rethrow;
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }

  Future<AuthLoginPayload> patientLoginWithOtp({
    required String phone10Digits,
    required String otpCode,
  }) async {
    final key = Object.hash(phone10Digits, otpCode);
    if (_inFlightPatientOtpLogin != null) {
      if (_patientOtpCoalesceKey == key) {
        return _inFlightPatientOtpLogin!;
      }
      const msg = 'Please wait for the current sign-in to finish.';
      ref.read(asyncTrackerProvider.notifier).reportError(AuthOperationIds.patientLoginWithOtp, msg);
      throw AuthRepositoryException(msg);
    }
    _patientOtpCoalesceKey = key;
    return _inFlightPatientOtpLogin = _patientLoginWithOtpBody(
      phone10Digits: phone10Digits,
      otpCode: otpCode,
    ).whenComplete(() {
      _inFlightPatientOtpLogin = null;
      _patientOtpCoalesceKey = null;
    });
  }

  Future<AuthLoginPayload> _patientLoginWithOtpBody({
    required String phone10Digits,
    required String otpCode,
  }) async {
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = AuthOperationIds.patientLoginWithOtp;
    tracker.start(op);
    try {
      final repo = ref.read(authRepositoryProvider);
      final payload = await repo.patientLoginWithOtp(
        phone10Digits: phone10Digits,
        otpCode: otpCode,
      );
      await ref.read(sessionControllerProvider.notifier).applyAuthenticatedSession(
            accessToken: payload.jwtToken,
            user: payload.user,
          );
      tracker.fulfill(op);
      return payload;
    } on AuthRepositoryException catch (e) {
      tracker.reportError(op, e.message);
      rethrow;
    } on Object catch (_) {
      tracker.reportError(op, 'Invalid OTP');
      rethrow;
    } finally {
      tracker.recoverStuckFetching(op);
    }
  }
}
