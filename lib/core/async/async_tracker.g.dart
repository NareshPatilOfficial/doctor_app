// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_tracker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Global map of async lifecycle metadata by operation id string.
/// Domain data stays in feature notifiers; this only tracks loading / errors / extras.

@ProviderFor(AsyncTracker)
const asyncTrackerProvider = AsyncTrackerProvider._();

/// Global map of async lifecycle metadata by operation id string.
/// Domain data stays in feature notifiers; this only tracks loading / errors / extras.
final class AsyncTrackerProvider
    extends $NotifierProvider<AsyncTracker, Map<String, AsyncOpState>> {
  /// Global map of async lifecycle metadata by operation id string.
  /// Domain data stays in feature notifiers; this only tracks loading / errors / extras.
  const AsyncTrackerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncTrackerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncTrackerHash();

  @$internal
  @override
  AsyncTracker create() => AsyncTracker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, AsyncOpState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, AsyncOpState>>(value),
    );
  }
}

String _$asyncTrackerHash() => r'006bd16a8f90271b44dc4eede25987201aba5be0';

/// Global map of async lifecycle metadata by operation id string.
/// Domain data stays in feature notifiers; this only tracks loading / errors / extras.

abstract class _$AsyncTracker extends $Notifier<Map<String, AsyncOpState>> {
  Map<String, AsyncOpState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<Map<String, AsyncOpState>, Map<String, AsyncOpState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, AsyncOpState>, Map<String, AsyncOpState>>,
              Map<String, AsyncOpState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
