import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'async_op_state.dart';
import 'async_tracker.dart';

part 'async_selectors.g.dart';

/// Selector-style providers: pass the same operation id string used with [AsyncTracker].

@riverpod
bool asyncIsFetching(Ref ref, String operationId) {
  return ref.watch(asyncTrackerProvider)[operationId]?.isFetching ?? false;
}

@riverpod
bool asyncWasRequested(Ref ref, String operationId) {
  return ref.watch(asyncTrackerProvider)[operationId]?.wasRequested ?? false;
}

@riverpod
String? asyncError(Ref ref, String operationId) {
  return ref.watch(asyncTrackerProvider)[operationId]?.error;
}

@riverpod
AsyncOpState? asyncState(Ref ref, String operationId) {
  return ref.watch(asyncTrackerProvider)[operationId];
}

@riverpod
Object? asyncFulfilledExtraData(Ref ref, String operationId) {
  return ref.watch(asyncTrackerProvider)[operationId]?.fulfilledExtraData;
}
