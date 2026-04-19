// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatientAccountState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientAccountState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientAccountState()';
}


}

/// @nodoc
class $PatientAccountStateCopyWith<$Res>  {
$PatientAccountStateCopyWith(PatientAccountState _, $Res Function(PatientAccountState) __);
}


/// Adds pattern-matching-related methods to [PatientAccountState].
extension PatientAccountStatePatterns on PatientAccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Inactive value)?  inactive,TResult Function( _Loading value)?  loading,TResult Function( _Ready value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Inactive() when inactive != null:
return inactive(_that);case _Loading() when loading != null:
return loading(_that);case _Ready() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Inactive value)  inactive,required TResult Function( _Loading value)  loading,required TResult Function( _Ready value)  ready,}){
final _that = this;
switch (_that) {
case _Inactive():
return inactive(_that);case _Loading():
return loading(_that);case _Ready():
return ready(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Inactive value)?  inactive,TResult? Function( _Loading value)?  loading,TResult? Function( _Ready value)?  ready,}){
final _that = this;
switch (_that) {
case _Inactive() when inactive != null:
return inactive(_that);case _Loading() when loading != null:
return loading(_that);case _Ready() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  inactive,TResult Function()?  loading,TResult Function( List<int> linkedUserIds,  int activeUserId,  UserProfileDto profile)?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Inactive() when inactive != null:
return inactive();case _Loading() when loading != null:
return loading();case _Ready() when ready != null:
return ready(_that.linkedUserIds,_that.activeUserId,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  inactive,required TResult Function()  loading,required TResult Function( List<int> linkedUserIds,  int activeUserId,  UserProfileDto profile)  ready,}) {final _that = this;
switch (_that) {
case _Inactive():
return inactive();case _Loading():
return loading();case _Ready():
return ready(_that.linkedUserIds,_that.activeUserId,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  inactive,TResult? Function()?  loading,TResult? Function( List<int> linkedUserIds,  int activeUserId,  UserProfileDto profile)?  ready,}) {final _that = this;
switch (_that) {
case _Inactive() when inactive != null:
return inactive();case _Loading() when loading != null:
return loading();case _Ready() when ready != null:
return ready(_that.linkedUserIds,_that.activeUserId,_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _Inactive implements PatientAccountState {
  const _Inactive();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inactive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientAccountState.inactive()';
}


}




/// @nodoc


class _Loading implements PatientAccountState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PatientAccountState.loading()';
}


}




/// @nodoc


class _Ready implements PatientAccountState {
  const _Ready({required final  List<int> linkedUserIds, required this.activeUserId, required this.profile}): _linkedUserIds = linkedUserIds;
  

 final  List<int> _linkedUserIds;
 List<int> get linkedUserIds {
  if (_linkedUserIds is EqualUnmodifiableListView) return _linkedUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_linkedUserIds);
}

 final  int activeUserId;
 final  UserProfileDto profile;

/// Create a copy of PatientAccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadyCopyWith<_Ready> get copyWith => __$ReadyCopyWithImpl<_Ready>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ready&&const DeepCollectionEquality().equals(other._linkedUserIds, _linkedUserIds)&&(identical(other.activeUserId, activeUserId) || other.activeUserId == activeUserId)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_linkedUserIds),activeUserId,profile);

@override
String toString() {
  return 'PatientAccountState.ready(linkedUserIds: $linkedUserIds, activeUserId: $activeUserId, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$ReadyCopyWith<$Res> implements $PatientAccountStateCopyWith<$Res> {
  factory _$ReadyCopyWith(_Ready value, $Res Function(_Ready) _then) = __$ReadyCopyWithImpl;
@useResult
$Res call({
 List<int> linkedUserIds, int activeUserId, UserProfileDto profile
});


$UserProfileDtoCopyWith<$Res> get profile;

}
/// @nodoc
class __$ReadyCopyWithImpl<$Res>
    implements _$ReadyCopyWith<$Res> {
  __$ReadyCopyWithImpl(this._self, this._then);

  final _Ready _self;
  final $Res Function(_Ready) _then;

/// Create a copy of PatientAccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? linkedUserIds = null,Object? activeUserId = null,Object? profile = null,}) {
  return _then(_Ready(
linkedUserIds: null == linkedUserIds ? _self._linkedUserIds : linkedUserIds // ignore: cast_nullable_to_non_nullable
as List<int>,activeUserId: null == activeUserId ? _self.activeUserId : activeUserId // ignore: cast_nullable_to_non_nullable
as int,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfileDto,
  ));
}

/// Create a copy of PatientAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileDtoCopyWith<$Res> get profile {
  
  return $UserProfileDtoCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
