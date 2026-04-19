// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_api_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthLoginPayload {

 String get jwtToken; User get user;
/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoginPayloadCopyWith<AuthLoginPayload> get copyWith => _$AuthLoginPayloadCopyWithImpl<AuthLoginPayload>(this as AuthLoginPayload, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoginPayload&&(identical(other.jwtToken, jwtToken) || other.jwtToken == jwtToken)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,jwtToken,user);

@override
String toString() {
  return 'AuthLoginPayload(jwtToken: $jwtToken, user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthLoginPayloadCopyWith<$Res>  {
  factory $AuthLoginPayloadCopyWith(AuthLoginPayload value, $Res Function(AuthLoginPayload) _then) = _$AuthLoginPayloadCopyWithImpl;
@useResult
$Res call({
 String jwtToken, User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthLoginPayloadCopyWithImpl<$Res>
    implements $AuthLoginPayloadCopyWith<$Res> {
  _$AuthLoginPayloadCopyWithImpl(this._self, this._then);

  final AuthLoginPayload _self;
  final $Res Function(AuthLoginPayload) _then;

/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jwtToken = null,Object? user = null,}) {
  return _then(_self.copyWith(
jwtToken: null == jwtToken ? _self.jwtToken : jwtToken // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}
/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthLoginPayload].
extension AuthLoginPayloadPatterns on AuthLoginPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthLoginPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthLoginPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthLoginPayload value)  $default,){
final _that = this;
switch (_that) {
case _AuthLoginPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthLoginPayload value)?  $default,){
final _that = this;
switch (_that) {
case _AuthLoginPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String jwtToken,  User user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthLoginPayload() when $default != null:
return $default(_that.jwtToken,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String jwtToken,  User user)  $default,) {final _that = this;
switch (_that) {
case _AuthLoginPayload():
return $default(_that.jwtToken,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String jwtToken,  User user)?  $default,) {final _that = this;
switch (_that) {
case _AuthLoginPayload() when $default != null:
return $default(_that.jwtToken,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _AuthLoginPayload implements AuthLoginPayload {
  const _AuthLoginPayload({required this.jwtToken, required this.user});
  

@override final  String jwtToken;
@override final  User user;

/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthLoginPayloadCopyWith<_AuthLoginPayload> get copyWith => __$AuthLoginPayloadCopyWithImpl<_AuthLoginPayload>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthLoginPayload&&(identical(other.jwtToken, jwtToken) || other.jwtToken == jwtToken)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,jwtToken,user);

@override
String toString() {
  return 'AuthLoginPayload(jwtToken: $jwtToken, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthLoginPayloadCopyWith<$Res> implements $AuthLoginPayloadCopyWith<$Res> {
  factory _$AuthLoginPayloadCopyWith(_AuthLoginPayload value, $Res Function(_AuthLoginPayload) _then) = __$AuthLoginPayloadCopyWithImpl;
@override @useResult
$Res call({
 String jwtToken, User user
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthLoginPayloadCopyWithImpl<$Res>
    implements _$AuthLoginPayloadCopyWith<$Res> {
  __$AuthLoginPayloadCopyWithImpl(this._self, this._then);

  final _AuthLoginPayload _self;
  final $Res Function(_AuthLoginPayload) _then;

/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jwtToken = null,Object? user = null,}) {
  return _then(_AuthLoginPayload(
jwtToken: null == jwtToken ? _self.jwtToken : jwtToken // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of AuthLoginPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
