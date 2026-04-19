// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).
///
/// In-flight calls are **coalesced** only when the request parameters match
/// (same Future for double-taps). A concurrent call with **different** inputs
/// throws [AuthRepositoryException] so callers never receive another user's result.

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).
///
/// In-flight calls are **coalesced** only when the request parameters match
/// (same Future for double-taps). A concurrent call with **different** inputs
/// throws [AuthRepositoryException] so callers never receive another user's result.
final class AuthNotifierProvider extends $NotifierProvider<AuthNotifier, void> {
  /// Coordinates auth API calls and [SessionController] persistence.
  ///
  /// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
  /// per [AuthOperationIds] for shared UI (spinners, messages).
  ///
  /// In-flight calls are **coalesced** only when the request parameters match
  /// (same Future for double-taps). A concurrent call with **different** inputs
  /// throws [AuthRepositoryException] so callers never receive another user's result.
  const AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$authNotifierHash() => r'd2cfc9aa596768c9d74e298dd9868d972e862429';

/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).
///
/// In-flight calls are **coalesced** only when the request parameters match
/// (same Future for double-taps). A concurrent call with **different** inputs
/// throws [AuthRepositoryException] so callers never receive another user's result.

abstract class _$AuthNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
