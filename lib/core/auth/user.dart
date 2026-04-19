// =============================================================================
// user.dart — Signed-in user model and role enum (Freezed + JSON)
// =============================================================================
// [UserRole] maps to API/string values via @JsonValue. Home path helpers live in
// role_route_extension.dart. Generated: user.freezed.dart, user.g.dart
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@JsonEnum(alwaysCreate: true)
enum UserRole {
  @JsonValue('admin')
  admin,
  @JsonValue('doctor')
  doctor,
  @JsonValue('staff')
  staff,
  @JsonValue('patient')
  patient,
  @JsonValue('chemist')
  chemist,
}

/// API / web `USER_ROLES` strings (`staff` = receptionist).
UserRole parseUserRole(String raw) {
  switch (raw.trim().toLowerCase()) {
    case 'admin':
      return UserRole.admin;
    case 'doctor':
      return UserRole.doctor;
    case 'staff':
      return UserRole.staff;
    case 'patient':
      return UserRole.patient;
    case 'chemist':
      return UserRole.chemist;
    default:
      return UserRole.patient;
  }
}

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String displayName,
    required UserRole role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Login response body (fields besides [jwtToken]) — web stores `name` on user.
  factory User.fromAuthResponse(Map<String, dynamic> json) {
    final name = json['name'] ?? json['displayName'];
    final display = name is String ? name : '$name';
    return User(
      id: json['id']?.toString() ?? '',
      displayName: display,
      role: parseUserRole(json['role'] as String? ?? 'patient'),
    );
  }
}
