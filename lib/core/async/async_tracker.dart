import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'async_op_state.dart';

part 'async_tracker.g.dart';

void _assertValidOperationId(String operationId) {
  if (operationId.isEmpty) {
    throw ArgumentError.value(operationId, 'operationId', 'must not be empty');
  }
}

/// Global map of async lifecycle metadata by operation id string.
/// Domain data stays in feature notifiers; this only tracks loading / errors / extras.
@Riverpod(keepAlive: true)
class AsyncTracker extends _$AsyncTracker {
  @override
  Map<String, AsyncOpState> build() => {};

  /// START — replaces bucket: fetching, requested, clears error.
  void start(String operationId) {
    _assertValidOperationId(operationId);
    state = {
      ...state,
      operationId: const AsyncOpState(
        isFetching: true,
        wasRequested: true,
        error: null,
        fulfilledExtraData: null,
      ),
    };
  }

  /// FULFILLED — ensures bucket exists; clears fetching and error.
  void fulfill(String operationId, {Object? fulfilledExtraData}) {
    _assertValidOperationId(operationId);
    final prev = state[operationId];
    final next = (prev ?? const AsyncOpState(wasRequested: true)).copyWith(
      isFetching: false,
      wasRequested: true,
      error: null,
      fulfilledExtraData: fulfilledExtraData ?? true,
    );
    state = {...state, operationId: next};
  }

  /// ERROR — stops fetching, marks requested, sets message.
  void reportError(String operationId, String message) {
    _assertValidOperationId(operationId);
    final prev = state[operationId] ?? const AsyncOpState();
    state = {
      ...state,
      operationId: prev.copyWith(
        isFetching: false,
        wasRequested: true,
        error: message,
      ),
    };
  }

  /// If [start] ran but neither [fulfill] nor [reportError] completed (e.g. unexpected
  /// throw), call this from a `finally` block to avoid leaving [isFetching] stuck true.
  void recoverStuckFetching(
    String operationId, {
    String message = 'Something went wrong. Please try again.',
  }) {
    _assertValidOperationId(operationId);
    final bucket = state[operationId];
    if (bucket != null && bucket.isFetching) {
      reportError(operationId, message);
    }
  }

  /// RESET — removes tracking for this operation.
  void reset(String operationId) {
    _assertValidOperationId(operationId);
    final next = Map<String, AsyncOpState>.from(state);
    next.remove(operationId);
    state = next;
  }

  /// RESET_ALL — clears entire async map.
  void resetAll() {
    state = {};
  }
}
