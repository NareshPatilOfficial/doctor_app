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
    /// From GET `/api/v1/users/{id}` after login (optional for older stored sessions).
    String? email,
    String? phone,
    String? firstName,
    String? middleName,
    String? lastName,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    String? gender,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Login response body (fields besides [jwtToken]) — web stores `name` on user.
  /// Patient responses may send [userIds] without a single `id`; first id is used.
  factory User.fromAuthResponse(Map<String, dynamic> json) {
    final name = json['name'] ?? json['displayName'];
    final display = name is String ? name : '$name';
    final ids = json['userIds'];
    String idStr = json['id']?.toString() ?? '';
    if (idStr.isEmpty && ids is List && ids.isNotEmpty) {
      idStr = ids.first.toString();
    }
    return User(
      id: idStr,
      displayName: display.isNotEmpty ? display : 'Patient',
      role: parseUserRole(json['role'] as String? ?? 'patient'),
    );
  }
}

/// Drawer / header: prefers name parts from profile API, else [User.displayName].
extension UserDrawerDisplay on User {
  String get drawerDisplayName {
    final parts = <String>[
      if (firstName != null && firstName!.trim().isNotEmpty) firstName!.trim(),
      if (middleName != null && middleName!.trim().isNotEmpty) middleName!.trim(),
      if (lastName != null && lastName!.trim().isNotEmpty) lastName!.trim(),
    ];
    if (parts.isNotEmpty) {
      return parts.join(' ');
    }
    final d = displayName.trim();
    if (d.isNotEmpty) {
      return d;
    }
    return 'User';
  }
}
