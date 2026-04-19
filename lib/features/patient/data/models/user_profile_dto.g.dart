// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDto _$UserProfileDtoFromJson(Map<String, dynamic> json) =>
    _UserProfileDto(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      profilePicture: json['profilePicture'] as String?,
      gender: json['gender'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      patientDetails: json['patientDetails'] == null
          ? null
          : PatientDetailsDto.fromJson(
              json['patientDetails'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserProfileDtoToJson(_UserProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'profilePicture': instance.profilePicture,
      'gender': instance.gender,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'patientDetails': instance.patientDetails,
    };

_PatientDetailsDto _$PatientDetailsDtoFromJson(Map<String, dynamic> json) =>
    _PatientDetailsDto(
      dateOfBirth: json['dateOfBirth'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      allergies: json['allergies'] as String?,
      chronicConditions: json['chronicConditions'] as String?,
      pastHistory: json['pastHistory'] as String?,
      familyHistory: json['familyHistory'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactPhone: json['emergencyContactPhone'] as String?,
      emergencyContactRelation: json['emergencyContactRelation'] as String?,
    );

Map<String, dynamic> _$PatientDetailsDtoToJson(_PatientDetailsDto instance) =>
    <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth,
      'bloodGroup': instance.bloodGroup,
      'allergies': instance.allergies,
      'chronicConditions': instance.chronicConditions,
      'pastHistory': instance.pastHistory,
      'familyHistory': instance.familyHistory,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
      'emergencyContactRelation': instance.emergencyContactRelation,
    };
