import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// GET `/api/v1/users/{userId}` and list response items.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required int id,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'middleName') String? middleName,
    @JsonKey(name: 'lastName') String? lastName,
    String? email,
    String? phone,
    String? role,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    String? gender,
    @JsonKey(name: 'addressLine1') String? addressLine1,
    @JsonKey(name: 'addressLine2') String? addressLine2,
    String? city,
    String? state,
    @JsonKey(name: 'postalCode') String? postalCode,
    String? country,
    @JsonKey(name: 'patientDetails') PatientDetailsDto? patientDetails,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);
}

@freezed
abstract class PatientDetailsDto with _$PatientDetailsDto {
  const factory PatientDetailsDto({
    @JsonKey(name: 'dateOfBirth') String? dateOfBirth,
    @JsonKey(name: 'bloodGroup') String? bloodGroup,
    String? allergies,
    @JsonKey(name: 'chronicConditions') String? chronicConditions,
    @JsonKey(name: 'pastHistory') String? pastHistory,
    @JsonKey(name: 'familyHistory') String? familyHistory,
    @JsonKey(name: 'emergencyContactName') String? emergencyContactName,
    @JsonKey(name: 'emergencyContactPhone') String? emergencyContactPhone,
    @JsonKey(name: 'emergencyContactRelation') String? emergencyContactRelation,
  }) = _PatientDetailsDto;

  factory PatientDetailsDto.fromJson(Map<String, dynamic> json) => _$PatientDetailsDtoFromJson(json);
}

extension UserProfileDtoDisplay on UserProfileDto {
  String get displayName {
    final parts = <String>[
      if (firstName != null && firstName!.isNotEmpty) firstName!,
      if (middleName != null && middleName!.isNotEmpty) middleName!,
      if (lastName != null && lastName!.isNotEmpty) lastName!,
    ];
    if (parts.isEmpty) {
      return 'Patient';
    }
    return parts.join(' ');
  }
}
