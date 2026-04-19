import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_api_models.freezed.dart';

/// Successful login / OTP verify — `jwtToken` + role; patient flows may include [userIds].
@freezed
abstract class AuthLoginPayload with _$AuthLoginPayload {
  const factory AuthLoginPayload({
    required String jwtToken,
    required User user,
    /// Patient login: linked accounts (default active = first id).
    List<int>? userIds,
    @Default(false) bool mfaRequired,
  }) = _AuthLoginPayload;
}

extension AuthLoginPayloadPatientIds on AuthLoginPayload {
  /// Ids to use for linked patient accounts; falls back to [User.id].
  List<int> get resolvedLinkedUserIds {
    if (userIds != null && userIds!.isNotEmpty) {
      return List<int>.from(userIds!);
    }
    final parsed = int.tryParse(user.id);
    if (parsed != null) {
      return <int>[parsed];
    }
    return <int>[];
  }
}
