// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'async_op_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AsyncOpState {

 bool get isFetching; bool get wasRequested; String? get error; Object? get fulfilledExtraData;
/// Create a copy of AsyncOpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AsyncOpStateCopyWith<AsyncOpState> get copyWith => _$AsyncOpStateCopyWithImpl<AsyncOpState>(this as AsyncOpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AsyncOpState&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching)&&(identical(other.wasRequested, wasRequested) || other.wasRequested == wasRequested)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.fulfilledExtraData, fulfilledExtraData));
}


@override
int get hashCode => Object.hash(runtimeType,isFetching,wasRequested,error,const DeepCollectionEquality().hash(fulfilledExtraData));

@override
String toString() {
  return 'AsyncOpState(isFetching: $isFetching, wasRequested: $wasRequested, error: $error, fulfilledExtraData: $fulfilledExtraData)';
}


}

/// @nodoc
abstract mixin class $AsyncOpStateCopyWith<$Res>  {
  factory $AsyncOpStateCopyWith(AsyncOpState value, $Res Function(AsyncOpState) _then) = _$AsyncOpStateCopyWithImpl;
@useResult
$Res call({
 bool isFetching, bool wasRequested, String? error, Object? fulfilledExtraData
});




}
/// @nodoc
class _$AsyncOpStateCopyWithImpl<$Res>
    implements $AsyncOpStateCopyWith<$Res> {
  _$AsyncOpStateCopyWithImpl(this._self, this._then);

  final AsyncOpState _self;
  final $Res Function(AsyncOpState) _then;

/// Create a copy of AsyncOpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isFetching = null,Object? wasRequested = null,Object? error = freezed,Object? fulfilledExtraData = freezed,}) {
  return _then(_self.copyWith(
isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,wasRequested: null == wasRequested ? _self.wasRequested : wasRequested // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,fulfilledExtraData: freezed == fulfilledExtraData ? _self.fulfilledExtraData : fulfilledExtraData ,
  ));
}

}


/// Adds pattern-matching-related methods to [AsyncOpState].
extension AsyncOpStatePatterns on AsyncOpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AsyncOpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AsyncOpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AsyncOpState value)  $default,){
final _that = this;
switch (_that) {
case _AsyncOpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AsyncOpState value)?  $default,){
final _that = this;
switch (_that) {
case _AsyncOpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isFetching,  bool wasRequested,  String? error,  Object? fulfilledExtraData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AsyncOpState() when $default != null:
return $default(_that.isFetching,_that.wasRequested,_that.error,_that.fulfilledExtraData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isFetching,  bool wasRequested,  String? error,  Object? fulfilledExtraData)  $default,) {final _that = this;
switch (_that) {
case _AsyncOpState():
return $default(_that.isFetching,_that.wasRequested,_that.error,_that.fulfilledExtraData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isFetching,  bool wasRequested,  String? error,  Object? fulfilledExtraData)?  $default,) {final _that = this;
switch (_that) {
case _AsyncOpState() when $default != null:
return $default(_that.isFetching,_that.wasRequested,_that.error,_that.fulfilledExtraData);case _:
  return null;

}
}

}

/// @nodoc


class _AsyncOpState implements AsyncOpState {
  const _AsyncOpState({this.isFetching = false, this.wasRequested = false, this.error, this.fulfilledExtraData});
  

@override@JsonKey() final  bool isFetching;
@override@JsonKey() final  bool wasRequested;
@override final  String? error;
@override final  Object? fulfilledExtraData;

/// Create a copy of AsyncOpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AsyncOpStateCopyWith<_AsyncOpState> get copyWith => __$AsyncOpStateCopyWithImpl<_AsyncOpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AsyncOpState&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching)&&(identical(other.wasRequested, wasRequested) || other.wasRequested == wasRequested)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.fulfilledExtraData, fulfilledExtraData));
}


@override
int get hashCode => Object.hash(runtimeType,isFetching,wasRequested,error,const DeepCollectionEquality().hash(fulfilledExtraData));

@override
String toString() {
  return 'AsyncOpState(isFetching: $isFetching, wasRequested: $wasRequested, error: $error, fulfilledExtraData: $fulfilledExtraData)';
}


}

/// @nodoc
abstract mixin class _$AsyncOpStateCopyWith<$Res> implements $AsyncOpStateCopyWith<$Res> {
  factory _$AsyncOpStateCopyWith(_AsyncOpState value, $Res Function(_AsyncOpState) _then) = __$AsyncOpStateCopyWithImpl;
@override @useResult
$Res call({
 bool isFetching, bool wasRequested, String? error, Object? fulfilledExtraData
});




}
/// @nodoc
class __$AsyncOpStateCopyWithImpl<$Res>
    implements _$AsyncOpStateCopyWith<$Res> {
  __$AsyncOpStateCopyWithImpl(this._self, this._then);

  final _AsyncOpState _self;
  final $Res Function(_AsyncOpState) _then;

/// Create a copy of AsyncOpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isFetching = null,Object? wasRequested = null,Object? error = freezed,Object? fulfilledExtraData = freezed,}) {
  return _then(_AsyncOpState(
isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,wasRequested: null == wasRequested ? _self.wasRequested : wasRequested // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,fulfilledExtraData: freezed == fulfilledExtraData ? _self.fulfilledExtraData : fulfilledExtraData ,
  ));
}


}

// dart format on
