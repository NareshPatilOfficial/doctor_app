import 'package:dio/dio.dart';

import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/core/utils/password_encoding.dart';
import 'package:doctorbridge_mobile_ui/core/utils/phone_utils.dart';
import 'models/auth_api_models.dart';

/// Unauthenticated auth API calls (no [Authorization] header when token is absent).
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  static const _loginPath = '/api/v1/auth/login';
  static const _sendOtpPath = '/api/v1/auth/send-otp';
  static const _patientLoginPath = '/api/v1/auth/patients/login';

  static const genericLoginError = 'Invalid phone number or password';

  Future<AuthLoginPayload> loginWithPassword({
    required String phone10Digits,
    required String password,
    required UserRole role,
  }) async {
    final phone = PhoneUtils.toIndiaE164(phone10Digits);
    final roleApi = switch (role) {
      UserRole.admin => 'admin',
      UserRole.doctor => 'doctor',
      UserRole.staff => 'staff',
      UserRole.patient => 'patient',
      UserRole.chemist => 'chemist',
    };
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        _loginPath,
        data: <String, dynamic>{
          'phone': phone,
          'password': encodePasswordAsBase64(password),
          'role': roleApi,
        },
      );
      return _parseLoginResponse(res.data!);
    } on DioException catch (e) {
      throw AuthRepositoryException(_messageOrDefault(e, genericLoginError));
    }
  }

  Future<void> sendOtp({required String phone10Digits}) async {
    final phone = PhoneUtils.toIndiaE164(phone10Digits);
    try {
      await _dio.post<Map<String, dynamic>>(
        _sendOtpPath,
        data: <String, dynamic>{'phone': phone},
      );
    } on DioException catch (e) {
      throw AuthRepositoryException(_messageOrDefault(e, 'Invalid phone number'));
    }
  }

  Future<AuthLoginPayload> patientLoginWithOtp({
    required String phone10Digits,
    required String otpCode,
  }) async {
    final phone = PhoneUtils.toIndiaE164(phone10Digits);
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        _patientLoginPath,
        data: <String, dynamic>{
          'phone': phone,
          'otpCode': otpCode,
        },
      );
      return _parseLoginResponse(res.data!);
    } on DioException catch (e) {
      throw AuthRepositoryException(_messageOrDefault(e, 'Invalid OTP'));
    }
  }

  AuthLoginPayload _parseLoginResponse(Map<String, dynamic> data) {
    final jwt = data['jwtToken'] as String?;
    if (jwt == null || jwt.isEmpty) {
      throw AuthRepositoryException(genericLoginError);
    }
    final userMap = Map<String, dynamic>.from(data)..remove('jwtToken');
    final user = User.fromAuthResponse(userMap);
    return AuthLoginPayload(
      jwtToken: jwt,
      user: user,
      userIds: _parseUserIds(data['userIds']),
      mfaRequired: data['mfaRequired'] as bool? ?? false,
    );
  }

  static List<int>? _parseUserIds(Object? raw) {
    if (raw is! List<dynamic>) {
      return null;
    }
    final out = <int>[];
    for (final e in raw) {
      if (e is int) {
        out.add(e);
      } else if (e is num) {
        out.add(e.toInt());
      }
    }
    return out.isEmpty ? null : out;
  }

  String _messageOrDefault(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String) {
      final m = data['message'] as String;
      if (m.isNotEmpty) {
        return m;
      }
    }
    return fallback;
  }
}

class AuthRepositoryException implements Exception {
  AuthRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}
