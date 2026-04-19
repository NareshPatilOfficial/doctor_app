// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  firstName: json['firstName'] as String?,
  middleName: json['middleName'] as String?,
  lastName: json['lastName'] as String?,
  profilePicture: json['profilePicture'] as String?,
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'role': _$UserRoleEnumMap[instance.role]!,
  'email': instance.email,
  'phone': instance.phone,
  'firstName': instance.firstName,
  'middleName': instance.middleName,
  'lastName': instance.lastName,
  'profilePicture': instance.profilePicture,
  'gender': instance.gender,
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.doctor: 'doctor',
  UserRole.staff: 'staff',
  UserRole.patient: 'patient',
  UserRole.chemist: 'chemist',
};
