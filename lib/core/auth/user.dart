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

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String displayName,
    required UserRole role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
