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

String _$asyncTrackerHash() => r'8e0f9d638201001bc2eb44c21b7ade4b1b7e1270';

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
