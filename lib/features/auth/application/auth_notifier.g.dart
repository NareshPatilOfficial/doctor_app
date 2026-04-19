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

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).
final class AuthNotifierProvider extends $NotifierProvider<AuthNotifier, void> {
  /// Coordinates auth API calls and [SessionController] persistence.
  ///
  /// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
  /// per [AuthOperationIds] for shared UI (spinners, messages).
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

String _$authNotifierHash() => r'b8239003d3fcd94e542981244aa13055e27c4449';

/// Coordinates auth API calls and [SessionController] persistence.
///
/// Dio calls go through [AuthRepository]; [AsyncTracker] records loading/errors
/// per [AuthOperationIds] for shared UI (spinners, messages).

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
