// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_selectors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Selector-style providers: pass the same operation id string used with [AsyncTracker].

@ProviderFor(asyncIsFetching)
const asyncIsFetchingProvider = AsyncIsFetchingFamily._();

/// Selector-style providers: pass the same operation id string used with [AsyncTracker].

final class AsyncIsFetchingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Selector-style providers: pass the same operation id string used with [AsyncTracker].
  const AsyncIsFetchingProvider._({
    required AsyncIsFetchingFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'asyncIsFetchingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncIsFetchingHash();

  @override
  String toString() {
    return r'asyncIsFetchingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return asyncIsFetching(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncIsFetchingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncIsFetchingHash() => r'79364fbf2cf473464a90d0993b2272885d7ade2c';

/// Selector-style providers: pass the same operation id string used with [AsyncTracker].

final class AsyncIsFetchingFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const AsyncIsFetchingFamily._()
    : super(
        retry: null,
        name: r'asyncIsFetchingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Selector-style providers: pass the same operation id string used with [AsyncTracker].

  AsyncIsFetchingProvider call(String operationId) =>
      AsyncIsFetchingProvider._(argument: operationId, from: this);

  @override
  String toString() => r'asyncIsFetchingProvider';
}

@ProviderFor(asyncWasRequested)
const asyncWasRequestedProvider = AsyncWasRequestedFamily._();

final class AsyncWasRequestedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const AsyncWasRequestedProvider._({
    required AsyncWasRequestedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'asyncWasRequestedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncWasRequestedHash();

  @override
  String toString() {
    return r'asyncWasRequestedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return asyncWasRequested(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncWasRequestedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncWasRequestedHash() => r'bf917885339617dc9a5b693c1a31d0c44cf6e59c';

final class AsyncWasRequestedFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  const AsyncWasRequestedFamily._()
    : super(
        retry: null,
        name: r'asyncWasRequestedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AsyncWasRequestedProvider call(String operationId) =>
      AsyncWasRequestedProvider._(argument: operationId, from: this);

  @override
  String toString() => r'asyncWasRequestedProvider';
}

@ProviderFor(asyncError)
const asyncErrorProvider = AsyncErrorFamily._();

final class AsyncErrorProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const AsyncErrorProvider._({
    required AsyncErrorFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'asyncErrorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncErrorHash();

  @override
  String toString() {
    return r'asyncErrorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    final argument = this.argument as String;
    return asyncError(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncErrorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncErrorHash() => r'bf572257c4f38ca896a7bc6e8671fadac6030f44';

final class AsyncErrorFamily extends $Family
    with $FunctionalFamilyOverride<String?, String> {
  const AsyncErrorFamily._()
    : super(
        retry: null,
        name: r'asyncErrorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AsyncErrorProvider call(String operationId) =>
      AsyncErrorProvider._(argument: operationId, from: this);

  @override
  String toString() => r'asyncErrorProvider';
}

@ProviderFor(asyncState)
const asyncStateProvider = AsyncStateFamily._();

final class AsyncStateProvider
    extends $FunctionalProvider<AsyncOpState?, AsyncOpState?, AsyncOpState?>
    with $Provider<AsyncOpState?> {
  const AsyncStateProvider._({
    required AsyncStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'asyncStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncStateHash();

  @override
  String toString() {
    return r'asyncStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncOpState?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncOpState? create(Ref ref) {
    final argument = this.argument as String;
    return asyncState(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncOpState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncOpState?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncStateHash() => r'43e108848e1d2485ddf676e41a0c106d84969248';

final class AsyncStateFamily extends $Family
    with $FunctionalFamilyOverride<AsyncOpState?, String> {
  const AsyncStateFamily._()
    : super(
        retry: null,
        name: r'asyncStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AsyncStateProvider call(String operationId) =>
      AsyncStateProvider._(argument: operationId, from: this);

  @override
  String toString() => r'asyncStateProvider';
}

@ProviderFor(asyncFulfilledExtraData)
const asyncFulfilledExtraDataProvider = AsyncFulfilledExtraDataFamily._();

final class AsyncFulfilledExtraDataProvider
    extends $FunctionalProvider<Object?, Object?, Object?>
    with $Provider<Object?> {
  const AsyncFulfilledExtraDataProvider._({
    required AsyncFulfilledExtraDataFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'asyncFulfilledExtraDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$asyncFulfilledExtraDataHash();

  @override
  String toString() {
    return r'asyncFulfilledExtraDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Object?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Object? create(Ref ref) {
    final argument = this.argument as String;
    return asyncFulfilledExtraData(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Object? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Object?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AsyncFulfilledExtraDataProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$asyncFulfilledExtraDataHash() =>
    r'f6901a906211d2d496c13c50ef0e7414b4e2dbb0';

final class AsyncFulfilledExtraDataFamily extends $Family
    with $FunctionalFamilyOverride<Object?, String> {
  const AsyncFulfilledExtraDataFamily._()
    : super(
        retry: null,
        name: r'asyncFulfilledExtraDataProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AsyncFulfilledExtraDataProvider call(String operationId) =>
      AsyncFulfilledExtraDataProvider._(argument: operationId, from: this);

  @override
  String toString() => r'asyncFulfilledExtraDataProvider';
}
