import 'package:freezed_annotation/freezed_annotation.dart';

part 'async_op_state.freezed.dart';

/// Per-operation bucket in [AsyncTracker], keyed by operation id (e.g. `POST_AUTH_LOGIN`).
@freezed
abstract class AsyncOpState with _$AsyncOpState {
  const factory AsyncOpState({
    @Default(false) bool isFetching,
    @Default(false) bool wasRequested,
    String? error,
    Object? fulfilledExtraData,
  }) = _AsyncOpState;
}
