import 'dart:async' show Timer, unawaited;

import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/core/utils/phone_utils.dart';
import 'package:doctorbridge_mobile_ui/features/auth/application/auth_notifier.dart';
import 'package:doctorbridge_mobile_ui/features/auth/data/auth_repository.dart';
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
  String? _sendError;
  String? _verifyError;
  bool _sendLoading = false;
  bool _verifyLoading = false;
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyLaunchArgs());
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
    if (_role == UserRole.patient && next != UserRole.patient) {
      _showSendOtp = true;
      _sendError = null;
      _verifyError = null;
      _resendTimer?.cancel();
      _resendSeconds = 0;
    }
    if (next == UserRole.patient && _role != UserRole.patient) {
      _showSendOtp = true;
      _sendError = null;
      _verifyError = null;
      _resendTimer?.cancel();
      _resendSeconds = 0;
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
    setState(() {
      _sendError = null;
      _verifyError = null;
    });
    try {
      await ref.read(authProvider.notifier).loginWithPassword(
            phone10Digits: digits,
            password: _password.text,
            role: _role,
          );
    } on AuthRepositoryException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } on Object catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AuthRepository.genericLoginError)),
        );
      }
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
      setState(() => _sendError = 'Enter a valid 10-digit phone number');
      return;
    }
    setState(() {
      _sendLoading = true;
      _sendError = null;
    });
    try {
      await ref.read(authProvider.notifier).sendPatientOtp(phone10Digits: digits);
      if (!mounted) {
        return;
      }
      setState(() {
        if (!resend) {
          _showSendOtp = false;
        }
        _sendLoading = false;
      });
      _startResendCooldown();
    } on AuthRepositoryException catch (e) {
      if (mounted) {
        setState(() {
          _sendLoading = false;
          _sendError = e.message;
        });
      }
    } on Object catch (_) {
      if (mounted) {
        setState(() {
          _sendLoading = false;
          _sendError = 'Invalid phone number';
        });
      }
    }
  }

  Future<void> _verifyOtp(String otp) async {
    final digits = PhoneUtils.stripToTenDigits(_phone.text);
    if (digits == null || otp.length != 6) {
      return;
    }
    setState(() {
      _verifyLoading = true;
      _verifyError = null;
    });
    try {
      await ref.read(authProvider.notifier).patientLoginWithOtp(
            phone10Digits: digits,
            otpCode: otp,
          );
    } on AuthRepositoryException catch (e) {
      if (mounted) {
        setState(() {
          _verifyError = e.message;
        });
      }
    } on Object catch (_) {
      if (mounted) {
        setState(() {
          _verifyError = 'Invalid OTP';
        });
      }
    } finally {
      if (mounted) {
        setState(() => _verifyLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                unawaited(_submitPassword());
              },
              child: const Text('Sign in'),
            ),
          ] else ...[
            PatientOtpSection(
              phoneReadOnly: !_showSendOtp,
              phoneController: _phone,
              onSendOtp: () {
                unawaited(_sendOtp());
              },
              onVerify: _verifyOtp,
              sendLoading: _sendLoading,
              verifyLoading: _verifyLoading,
              sendError: _sendError,
              verifyError: _verifyError,
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
