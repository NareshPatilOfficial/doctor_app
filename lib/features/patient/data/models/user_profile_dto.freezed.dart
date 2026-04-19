// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {

 int get id;@JsonKey(name: 'firstName') String? get firstName;@JsonKey(name: 'middleName') String? get middleName;@JsonKey(name: 'lastName') String? get lastName; String? get email; String? get phone; String? get role;@JsonKey(name: 'profilePicture') String? get profilePicture; String? get gender;@JsonKey(name: 'addressLine1') String? get addressLine1;@JsonKey(name: 'addressLine2') String? get addressLine2; String? get city; String? get state;@JsonKey(name: 'postalCode') String? get postalCode; String? get country;@JsonKey(name: 'patientDetails') PatientDetailsDto? get patientDetails;
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<UserProfileDto> get copyWith => _$UserProfileDtoCopyWithImpl<UserProfileDto>(this as UserProfileDto, _$identity);

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.addressLine1, addressLine1) || other.addressLine1 == addressLine1)&&(identical(other.addressLine2, addressLine2) || other.addressLine2 == addressLine2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.patientDetails, patientDetails) || other.patientDetails == patientDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,middleName,lastName,email,phone,role,profilePicture,gender,addressLine1,addressLine2,city,state,postalCode,country,patientDetails);

@override
String toString() {
  return 'UserProfileDto(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, phone: $phone, role: $role, profilePicture: $profilePicture, gender: $gender, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, postalCode: $postalCode, country: $country, patientDetails: $patientDetails)';
}


}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res>  {
  factory $UserProfileDtoCopyWith(UserProfileDto value, $Res Function(UserProfileDto) _then) = _$UserProfileDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'firstName') String? firstName,@JsonKey(name: 'middleName') String? middleName,@JsonKey(name: 'lastName') String? lastName, String? email, String? phone, String? role,@JsonKey(name: 'profilePicture') String? profilePicture, String? gender,@JsonKey(name: 'addressLine1') String? addressLine1,@JsonKey(name: 'addressLine2') String? addressLine2, String? city, String? state,@JsonKey(name: 'postalCode') String? postalCode, String? country,@JsonKey(name: 'patientDetails') PatientDetailsDto? patientDetails
});


$PatientDetailsDtoCopyWith<$Res>? get patientDetails;

}
/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = freezed,Object? middleName = freezed,Object? lastName = freezed,Object? email = freezed,Object? phone = freezed,Object? role = freezed,Object? profilePicture = freezed,Object? gender = freezed,Object? addressLine1 = freezed,Object? addressLine2 = freezed,Object? city = freezed,Object? state = freezed,Object? postalCode = freezed,Object? country = freezed,Object? patientDetails = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,middleName: freezed == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,addressLine1: freezed == addressLine1 ? _self.addressLine1 : addressLine1 // ignore: cast_nullable_to_non_nullable
as String?,addressLine2: freezed == addressLine2 ? _self.addressLine2 : addressLine2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,patientDetails: freezed == patientDetails ? _self.patientDetails : patientDetails // ignore: cast_nullable_to_non_nullable
as PatientDetailsDto?,
  ));
}
/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientDetailsDtoCopyWith<$Res>? get patientDetails {
    if (_self.patientDetails == null) {
    return null;
  }

  return $PatientDetailsDtoCopyWith<$Res>(_self.patientDetails!, (value) {
    return _then(_self.copyWith(patientDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileDto].
extension UserProfileDtoPatterns on UserProfileDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'firstName')  String? firstName, @JsonKey(name: 'middleName')  String? middleName, @JsonKey(name: 'lastName')  String? lastName,  String? email,  String? phone,  String? role, @JsonKey(name: 'profilePicture')  String? profilePicture,  String? gender, @JsonKey(name: 'addressLine1')  String? addressLine1, @JsonKey(name: 'addressLine2')  String? addressLine2,  String? city,  String? state, @JsonKey(name: 'postalCode')  String? postalCode,  String? country, @JsonKey(name: 'patientDetails')  PatientDetailsDto? patientDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.firstName,_that.middleName,_that.lastName,_that.email,_that.phone,_that.role,_that.profilePicture,_that.gender,_that.addressLine1,_that.addressLine2,_that.city,_that.state,_that.postalCode,_that.country,_that.patientDetails);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'firstName')  String? firstName, @JsonKey(name: 'middleName')  String? middleName, @JsonKey(name: 'lastName')  String? lastName,  String? email,  String? phone,  String? role, @JsonKey(name: 'profilePicture')  String? profilePicture,  String? gender, @JsonKey(name: 'addressLine1')  String? addressLine1, @JsonKey(name: 'addressLine2')  String? addressLine2,  String? city,  String? state, @JsonKey(name: 'postalCode')  String? postalCode,  String? country, @JsonKey(name: 'patientDetails')  PatientDetailsDto? patientDetails)  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto():
return $default(_that.id,_that.firstName,_that.middleName,_that.lastName,_that.email,_that.phone,_that.role,_that.profilePicture,_that.gender,_that.addressLine1,_that.addressLine2,_that.city,_that.state,_that.postalCode,_that.country,_that.patientDetails);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'firstName')  String? firstName, @JsonKey(name: 'middleName')  String? middleName, @JsonKey(name: 'lastName')  String? lastName,  String? email,  String? phone,  String? role, @JsonKey(name: 'profilePicture')  String? profilePicture,  String? gender, @JsonKey(name: 'addressLine1')  String? addressLine1, @JsonKey(name: 'addressLine2')  String? addressLine2,  String? city,  String? state, @JsonKey(name: 'postalCode')  String? postalCode,  String? country, @JsonKey(name: 'patientDetails')  PatientDetailsDto? patientDetails)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileDto() when $default != null:
return $default(_that.id,_that.firstName,_that.middleName,_that.lastName,_that.email,_that.phone,_that.role,_that.profilePicture,_that.gender,_that.addressLine1,_that.addressLine2,_that.city,_that.state,_that.postalCode,_that.country,_that.patientDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileDto implements UserProfileDto {
  const _UserProfileDto({required this.id, @JsonKey(name: 'firstName') this.firstName, @JsonKey(name: 'middleName') this.middleName, @JsonKey(name: 'lastName') this.lastName, this.email, this.phone, this.role, @JsonKey(name: 'profilePicture') this.profilePicture, this.gender, @JsonKey(name: 'addressLine1') this.addressLine1, @JsonKey(name: 'addressLine2') this.addressLine2, this.city, this.state, @JsonKey(name: 'postalCode') this.postalCode, this.country, @JsonKey(name: 'patientDetails') this.patientDetails});
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'firstName') final  String? firstName;
@override@JsonKey(name: 'middleName') final  String? middleName;
@override@JsonKey(name: 'lastName') final  String? lastName;
@override final  String? email;
@override final  String? phone;
@override final  String? role;
@override@JsonKey(name: 'profilePicture') final  String? profilePicture;
@override final  String? gender;
@override@JsonKey(name: 'addressLine1') final  String? addressLine1;
@override@JsonKey(name: 'addressLine2') final  String? addressLine2;
@override final  String? city;
@override final  String? state;
@override@JsonKey(name: 'postalCode') final  String? postalCode;
@override final  String? country;
@override@JsonKey(name: 'patientDetails') final  PatientDetailsDto? patientDetails;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDtoCopyWith<_UserProfileDto> get copyWith => __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.addressLine1, addressLine1) || other.addressLine1 == addressLine1)&&(identical(other.addressLine2, addressLine2) || other.addressLine2 == addressLine2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.patientDetails, patientDetails) || other.patientDetails == patientDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,middleName,lastName,email,phone,role,profilePicture,gender,addressLine1,addressLine2,city,state,postalCode,country,patientDetails);

@override
String toString() {
  return 'UserProfileDto(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, phone: $phone, role: $role, profilePicture: $profilePicture, gender: $gender, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, postalCode: $postalCode, country: $country, patientDetails: $patientDetails)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res> implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(_UserProfileDto value, $Res Function(_UserProfileDto) _then) = __$UserProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'firstName') String? firstName,@JsonKey(name: 'middleName') String? middleName,@JsonKey(name: 'lastName') String? lastName, String? email, String? phone, String? role,@JsonKey(name: 'profilePicture') String? profilePicture, String? gender,@JsonKey(name: 'addressLine1') String? addressLine1,@JsonKey(name: 'addressLine2') String? addressLine2, String? city, String? state,@JsonKey(name: 'postalCode') String? postalCode, String? country,@JsonKey(name: 'patientDetails') PatientDetailsDto? patientDetails
});


@override $PatientDetailsDtoCopyWith<$Res>? get patientDetails;

}
/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = freezed,Object? middleName = freezed,Object? lastName = freezed,Object? email = freezed,Object? phone = freezed,Object? role = freezed,Object? profilePicture = freezed,Object? gender = freezed,Object? addressLine1 = freezed,Object? addressLine2 = freezed,Object? city = freezed,Object? state = freezed,Object? postalCode = freezed,Object? country = freezed,Object? patientDetails = freezed,}) {
  return _then(_UserProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,middleName: freezed == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,addressLine1: freezed == addressLine1 ? _self.addressLine1 : addressLine1 // ignore: cast_nullable_to_non_nullable
as String?,addressLine2: freezed == addressLine2 ? _self.addressLine2 : addressLine2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,patientDetails: freezed == patientDetails ? _self.patientDetails : patientDetails // ignore: cast_nullable_to_non_nullable
as PatientDetailsDto?,
  ));
}

/// Create a copy of UserProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientDetailsDtoCopyWith<$Res>? get patientDetails {
    if (_self.patientDetails == null) {
    return null;
  }

  return $PatientDetailsDtoCopyWith<$Res>(_self.patientDetails!, (value) {
    return _then(_self.copyWith(patientDetails: value));
  });
}
}


/// @nodoc
mixin _$PatientDetailsDto {

@JsonKey(name: 'dateOfBirth') String? get dateOfBirth;@JsonKey(name: 'bloodGroup') String? get bloodGroup; String? get allergies;@JsonKey(name: 'chronicConditions') String? get chronicConditions;@JsonKey(name: 'pastHistory') String? get pastHistory;@JsonKey(name: 'familyHistory') String? get familyHistory;@JsonKey(name: 'emergencyContactName') String? get emergencyContactName;@JsonKey(name: 'emergencyContactPhone') String? get emergencyContactPhone;@JsonKey(name: 'emergencyContactRelation') String? get emergencyContactRelation;
/// Create a copy of PatientDetailsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientDetailsDtoCopyWith<PatientDetailsDto> get copyWith => _$PatientDetailsDtoCopyWithImpl<PatientDetailsDto>(this as PatientDetailsDto, _$identity);

  /// Serializes this PatientDetailsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientDetailsDto&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.chronicConditions, chronicConditions) || other.chronicConditions == chronicConditions)&&(identical(other.pastHistory, pastHistory) || other.pastHistory == pastHistory)&&(identical(other.familyHistory, familyHistory) || other.familyHistory == familyHistory)&&(identical(other.emergencyContactName, emergencyContactName) || other.emergencyContactName == emergencyContactName)&&(identical(other.emergencyContactPhone, emergencyContactPhone) || other.emergencyContactPhone == emergencyContactPhone)&&(identical(other.emergencyContactRelation, emergencyContactRelation) || other.emergencyContactRelation == emergencyContactRelation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,bloodGroup,allergies,chronicConditions,pastHistory,familyHistory,emergencyContactName,emergencyContactPhone,emergencyContactRelation);

@override
String toString() {
  return 'PatientDetailsDto(dateOfBirth: $dateOfBirth, bloodGroup: $bloodGroup, allergies: $allergies, chronicConditions: $chronicConditions, pastHistory: $pastHistory, familyHistory: $familyHistory, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, emergencyContactRelation: $emergencyContactRelation)';
}


}

/// @nodoc
abstract mixin class $PatientDetailsDtoCopyWith<$Res>  {
  factory $PatientDetailsDtoCopyWith(PatientDetailsDto value, $Res Function(PatientDetailsDto) _then) = _$PatientDetailsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'dateOfBirth') String? dateOfBirth,@JsonKey(name: 'bloodGroup') String? bloodGroup, String? allergies,@JsonKey(name: 'chronicConditions') String? chronicConditions,@JsonKey(name: 'pastHistory') String? pastHistory,@JsonKey(name: 'familyHistory') String? familyHistory,@JsonKey(name: 'emergencyContactName') String? emergencyContactName,@JsonKey(name: 'emergencyContactPhone') String? emergencyContactPhone,@JsonKey(name: 'emergencyContactRelation') String? emergencyContactRelation
});




}
/// @nodoc
class _$PatientDetailsDtoCopyWithImpl<$Res>
    implements $PatientDetailsDtoCopyWith<$Res> {
  _$PatientDetailsDtoCopyWithImpl(this._self, this._then);

  final PatientDetailsDto _self;
  final $Res Function(PatientDetailsDto) _then;

/// Create a copy of PatientDetailsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateOfBirth = freezed,Object? bloodGroup = freezed,Object? allergies = freezed,Object? chronicConditions = freezed,Object? pastHistory = freezed,Object? familyHistory = freezed,Object? emergencyContactName = freezed,Object? emergencyContactPhone = freezed,Object? emergencyContactRelation = freezed,}) {
  return _then(_self.copyWith(
dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,bloodGroup: freezed == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String?,allergies: freezed == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String?,chronicConditions: freezed == chronicConditions ? _self.chronicConditions : chronicConditions // ignore: cast_nullable_to_non_nullable
as String?,pastHistory: freezed == pastHistory ? _self.pastHistory : pastHistory // ignore: cast_nullable_to_non_nullable
as String?,familyHistory: freezed == familyHistory ? _self.familyHistory : familyHistory // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactName: freezed == emergencyContactName ? _self.emergencyContactName : emergencyContactName // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactPhone: freezed == emergencyContactPhone ? _self.emergencyContactPhone : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactRelation: freezed == emergencyContactRelation ? _self.emergencyContactRelation : emergencyContactRelation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientDetailsDto].
extension PatientDetailsDtoPatterns on PatientDetailsDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientDetailsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientDetailsDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientDetailsDto value)  $default,){
final _that = this;
switch (_that) {
case _PatientDetailsDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientDetailsDto value)?  $default,){
final _that = this;
switch (_that) {
case _PatientDetailsDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'dateOfBirth')  String? dateOfBirth, @JsonKey(name: 'bloodGroup')  String? bloodGroup,  String? allergies, @JsonKey(name: 'chronicConditions')  String? chronicConditions, @JsonKey(name: 'pastHistory')  String? pastHistory, @JsonKey(name: 'familyHistory')  String? familyHistory, @JsonKey(name: 'emergencyContactName')  String? emergencyContactName, @JsonKey(name: 'emergencyContactPhone')  String? emergencyContactPhone, @JsonKey(name: 'emergencyContactRelation')  String? emergencyContactRelation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientDetailsDto() when $default != null:
return $default(_that.dateOfBirth,_that.bloodGroup,_that.allergies,_that.chronicConditions,_that.pastHistory,_that.familyHistory,_that.emergencyContactName,_that.emergencyContactPhone,_that.emergencyContactRelation);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'dateOfBirth')  String? dateOfBirth, @JsonKey(name: 'bloodGroup')  String? bloodGroup,  String? allergies, @JsonKey(name: 'chronicConditions')  String? chronicConditions, @JsonKey(name: 'pastHistory')  String? pastHistory, @JsonKey(name: 'familyHistory')  String? familyHistory, @JsonKey(name: 'emergencyContactName')  String? emergencyContactName, @JsonKey(name: 'emergencyContactPhone')  String? emergencyContactPhone, @JsonKey(name: 'emergencyContactRelation')  String? emergencyContactRelation)  $default,) {final _that = this;
switch (_that) {
case _PatientDetailsDto():
return $default(_that.dateOfBirth,_that.bloodGroup,_that.allergies,_that.chronicConditions,_that.pastHistory,_that.familyHistory,_that.emergencyContactName,_that.emergencyContactPhone,_that.emergencyContactRelation);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'dateOfBirth')  String? dateOfBirth, @JsonKey(name: 'bloodGroup')  String? bloodGroup,  String? allergies, @JsonKey(name: 'chronicConditions')  String? chronicConditions, @JsonKey(name: 'pastHistory')  String? pastHistory, @JsonKey(name: 'familyHistory')  String? familyHistory, @JsonKey(name: 'emergencyContactName')  String? emergencyContactName, @JsonKey(name: 'emergencyContactPhone')  String? emergencyContactPhone, @JsonKey(name: 'emergencyContactRelation')  String? emergencyContactRelation)?  $default,) {final _that = this;
switch (_that) {
case _PatientDetailsDto() when $default != null:
return $default(_that.dateOfBirth,_that.bloodGroup,_that.allergies,_that.chronicConditions,_that.pastHistory,_that.familyHistory,_that.emergencyContactName,_that.emergencyContactPhone,_that.emergencyContactRelation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientDetailsDto implements PatientDetailsDto {
  const _PatientDetailsDto({@JsonKey(name: 'dateOfBirth') this.dateOfBirth, @JsonKey(name: 'bloodGroup') this.bloodGroup, this.allergies, @JsonKey(name: 'chronicConditions') this.chronicConditions, @JsonKey(name: 'pastHistory') this.pastHistory, @JsonKey(name: 'familyHistory') this.familyHistory, @JsonKey(name: 'emergencyContactName') this.emergencyContactName, @JsonKey(name: 'emergencyContactPhone') this.emergencyContactPhone, @JsonKey(name: 'emergencyContactRelation') this.emergencyContactRelation});
  factory _PatientDetailsDto.fromJson(Map<String, dynamic> json) => _$PatientDetailsDtoFromJson(json);

@override@JsonKey(name: 'dateOfBirth') final  String? dateOfBirth;
@override@JsonKey(name: 'bloodGroup') final  String? bloodGroup;
@override final  String? allergies;
@override@JsonKey(name: 'chronicConditions') final  String? chronicConditions;
@override@JsonKey(name: 'pastHistory') final  String? pastHistory;
@override@JsonKey(name: 'familyHistory') final  String? familyHistory;
@override@JsonKey(name: 'emergencyContactName') final  String? emergencyContactName;
@override@JsonKey(name: 'emergencyContactPhone') final  String? emergencyContactPhone;
@override@JsonKey(name: 'emergencyContactRelation') final  String? emergencyContactRelation;

/// Create a copy of PatientDetailsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientDetailsDtoCopyWith<_PatientDetailsDto> get copyWith => __$PatientDetailsDtoCopyWithImpl<_PatientDetailsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientDetailsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientDetailsDto&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.bloodGroup, bloodGroup) || other.bloodGroup == bloodGroup)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.chronicConditions, chronicConditions) || other.chronicConditions == chronicConditions)&&(identical(other.pastHistory, pastHistory) || other.pastHistory == pastHistory)&&(identical(other.familyHistory, familyHistory) || other.familyHistory == familyHistory)&&(identical(other.emergencyContactName, emergencyContactName) || other.emergencyContactName == emergencyContactName)&&(identical(other.emergencyContactPhone, emergencyContactPhone) || other.emergencyContactPhone == emergencyContactPhone)&&(identical(other.emergencyContactRelation, emergencyContactRelation) || other.emergencyContactRelation == emergencyContactRelation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateOfBirth,bloodGroup,allergies,chronicConditions,pastHistory,familyHistory,emergencyContactName,emergencyContactPhone,emergencyContactRelation);

@override
String toString() {
  return 'PatientDetailsDto(dateOfBirth: $dateOfBirth, bloodGroup: $bloodGroup, allergies: $allergies, chronicConditions: $chronicConditions, pastHistory: $pastHistory, familyHistory: $familyHistory, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, emergencyContactRelation: $emergencyContactRelation)';
}


}

/// @nodoc
abstract mixin class _$PatientDetailsDtoCopyWith<$Res> implements $PatientDetailsDtoCopyWith<$Res> {
  factory _$PatientDetailsDtoCopyWith(_PatientDetailsDto value, $Res Function(_PatientDetailsDto) _then) = __$PatientDetailsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'dateOfBirth') String? dateOfBirth,@JsonKey(name: 'bloodGroup') String? bloodGroup, String? allergies,@JsonKey(name: 'chronicConditions') String? chronicConditions,@JsonKey(name: 'pastHistory') String? pastHistory,@JsonKey(name: 'familyHistory') String? familyHistory,@JsonKey(name: 'emergencyContactName') String? emergencyContactName,@JsonKey(name: 'emergencyContactPhone') String? emergencyContactPhone,@JsonKey(name: 'emergencyContactRelation') String? emergencyContactRelation
});




}
/// @nodoc
class __$PatientDetailsDtoCopyWithImpl<$Res>
    implements _$PatientDetailsDtoCopyWith<$Res> {
  __$PatientDetailsDtoCopyWithImpl(this._self, this._then);

  final _PatientDetailsDto _self;
  final $Res Function(_PatientDetailsDto) _then;

/// Create a copy of PatientDetailsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateOfBirth = freezed,Object? bloodGroup = freezed,Object? allergies = freezed,Object? chronicConditions = freezed,Object? pastHistory = freezed,Object? familyHistory = freezed,Object? emergencyContactName = freezed,Object? emergencyContactPhone = freezed,Object? emergencyContactRelation = freezed,}) {
  return _then(_PatientDetailsDto(
dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,bloodGroup: freezed == bloodGroup ? _self.bloodGroup : bloodGroup // ignore: cast_nullable_to_non_nullable
as String?,allergies: freezed == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String?,chronicConditions: freezed == chronicConditions ? _self.chronicConditions : chronicConditions // ignore: cast_nullable_to_non_nullable
as String?,pastHistory: freezed == pastHistory ? _self.pastHistory : pastHistory // ignore: cast_nullable_to_non_nullable
as String?,familyHistory: freezed == familyHistory ? _self.familyHistory : familyHistory // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactName: freezed == emergencyContactName ? _self.emergencyContactName : emergencyContactName // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactPhone: freezed == emergencyContactPhone ? _self.emergencyContactPhone : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
as String?,emergencyContactRelation: freezed == emergencyContactRelation ? _self.emergencyContactRelation : emergencyContactRelation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
