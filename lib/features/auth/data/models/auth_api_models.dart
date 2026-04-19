import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_api_models.freezed.dart';

/// Successful login / OTP verify — same JSON shape as web (`jwtToken` + user fields).
@freezed
abstract class AuthLoginPayload with _$AuthLoginPayload {
  const factory AuthLoginPayload({
    required String jwtToken,
    required User user,
  }) = _AuthLoginPayload;
}
