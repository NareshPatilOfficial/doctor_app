import 'dart:async' show Timer, unawaited;

import 'package:doctorbridge_mobile_ui/core/async/async_selectors.dart';
import 'package:doctorbridge_mobile_ui/core/async/async_tracker.dart';
import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/core/utils/phone_utils.dart';
import 'package:doctorbridge_mobile_ui/features/auth/application/auth_notifier.dart';
import 'package:doctorbridge_mobile_ui/features/auth/application/auth_operation_ids.dart';
import 'package:doctorbridge_mobile_ui/features/auth/presentation/login/login_launch_extra.dart';
import 'package:doctorbridge_mobile_ui/features/auth/presentation/otp_widgets/patient_otp_section.dart';
import 'package:doctorbridge_mobile_ui/features/auth/presentation/widgets/role_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Password login (non-patient) and OTP login (patient), aligned with web [LoginPage].
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phone = TextEditingController();
  final _password = TextEditingController();

  UserRole _role = UserRole.doctor;

  bool _showSendOtp = true;
  /// Client-side validation only; API errors use [AsyncTracker] + [asyncErrorProvider].
  String? _validationSendError;
  int _resendSeconds = 0;
  Timer? _resendTimer;

  @override
  void dispose() {
    _resendTimer?.cancel();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(asyncTrackerProvider.notifier)
        ..reset(AuthOperationIds.loginWithPassword)
        ..reset(AuthOperationIds.sendPatientOtp)
        ..reset(AuthOperationIds.patientLoginWithOtp);
      _applyLaunchArgs();
    });
  }

  void _applyLaunchArgs() {
    if (!mounted) {
      return;
    }
    final state = GoRouterState.of(context);
    final extra = state.extra;
    if (extra is LoginLaunchExtra && extra.returnPath != null && extra.returnPath!.isNotEmpty) {
      ref.read(sessionControllerProvider.notifier).setPendingPostLoginPath(extra.returnPath);
      setState(() {
        _role = UserRole.patient;
      });
    }
    final q = state.uri.queryParameters[RoutePaths.returnUrlQueryParam];
    if (q != null && q.isNotEmpty && q.contains('patientBookAppointment')) {
      setState(() {
        _role = UserRole.patient;
      });
    }
  }

  void _resetPatientOtpIfNeeded(UserRole next) {
    final tracker = ref.read(asyncTrackerProvider.notifier);
    if (_role == UserRole.patient && next != UserRole.patient) {
      _showSendOtp = true;
      _validationSendError = null;
      _resendTimer?.cancel();
      _resendSeconds = 0;
      tracker
        ..reset(AuthOperationIds.sendPatientOtp)
        ..reset(AuthOperationIds.patientLoginWithOtp);
    }
    if (next == UserRole.patient && _role != UserRole.patient) {
      _showSendOtp = true;
      _validationSendError = null;
      _resendTimer?.cancel();
      _resendSeconds = 0;
      tracker
        ..reset(AuthOperationIds.sendPatientOtp)
        ..reset(AuthOperationIds.patientLoginWithOtp);
    }
  }

  bool get _roleSelectorEnabled {
    if (_role != UserRole.patient) {
      return true;
    }
    return _showSendOtp;
  }

  Future<void> _submitPassword() async {
    final digits = PhoneUtils.stripToTenDigits(_phone.text);
    if (digits == null || _password.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit phone and password (min 6 characters).')),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authProvider.notifier).loginWithPassword(
            phone10Digits: digits,
            password: _password.text,
            role: _role,
          );
    } on Object {
      // Error message is in [AsyncTracker]; [ref.listen] shows a SnackBar.
    }
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendSeconds = 30;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _resendSeconds--;
        if (_resendSeconds <= 0) {
          t.cancel();
        }
      });
    });
  }

  Future<void> _sendOtp({bool resend = false}) async {
    final digits = PhoneUtils.stripToTenDigits(_phone.text);
    if (digits == null) {
      setState(() => _validationSendError = 'Enter a valid 10-digit phone number');
      return;
    }
    setState(() => _validationSendError = null);
    try {
      await ref.read(authProvider.notifier).sendPatientOtp(phone10Digits: digits);
      if (!mounted) {
        return;
      }
      setState(() {
        if (!resend) {
          _showSendOtp = false;
        }
      });
      _startResendCooldown();
    } on Object {
      // API message is in [AsyncTracker].
    }
  }

  Future<void> _verifyOtp(String otp) async {
    final digits = PhoneUtils.stripToTenDigits(_phone.text);
    if (digits == null || otp.length != 6) {
      return;
    }
    try {
      await ref.read(authProvider.notifier).patientLoginWithOtp(
            phone10Digits: digits,
            otpCode: otp,
          );
    } on Object {
      // API message is in [AsyncTracker].
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordLoginFetching =
        ref.watch(asyncIsFetchingProvider(AuthOperationIds.loginWithPassword));
    final sendOtpFetching = ref.watch(asyncIsFetchingProvider(AuthOperationIds.sendPatientOtp));
    final verifyOtpFetching =
        ref.watch(asyncIsFetchingProvider(AuthOperationIds.patientLoginWithOtp));
    final apiSendError = ref.watch(asyncErrorProvider(AuthOperationIds.sendPatientOtp));
    final verifyError = ref.watch(asyncErrorProvider(AuthOperationIds.patientLoginWithOtp));

    ref.listen(asyncErrorProvider(AuthOperationIds.loginWithPassword), (prev, next) {
      if (next != null && next.isNotEmpty && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          RoleSelector(
            value: _role,
            enabled: _roleSelectorEnabled,
            onChanged: (r) {
              setState(() {
                _resetPatientOtpIfNeeded(r);
                _role = r;
              });
            },
          ),
          const SizedBox(height: 16),
          if (_role != UserRole.patient) ...[
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Phone number',
                prefixText: '+91 ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: passwordLoginFetching
                  ? null
                  : () {
                      unawaited(_submitPassword());
                    },
              child: passwordLoginFetching
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Sign in'),
            ),
          ] else ...[
            PatientOtpSection(
              phoneReadOnly: !_showSendOtp,
              phoneController: _phone,
              onSendOtp: () {
                unawaited(_sendOtp());
              },
              onVerify: _verifyOtp,
              sendLoading: sendOtpFetching,
              verifyLoading: verifyOtpFetching,
              sendError: _validationSendError ?? apiSendError,
              verifyError: verifyError,
              showSendStep: _showSendOtp,
              resendSecondsLeft: _resendSeconds,
              onResend: () {
                if (_resendSeconds <= 0) {
                  unawaited(_sendOtp(resend: true));
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}
