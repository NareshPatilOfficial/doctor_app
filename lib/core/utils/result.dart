// =============================================================================
// result.dart — Result<T, E> and AppFailure for domain boundaries
// =============================================================================
// Use [Result] / [AppResult] in repositories or use-cases. [ApiExceptionToFailure]
// maps network errors to [AppFailure]. Keeps widgets from handling raw Dio types.
// =============================================================================

import '../network/api_exception.dart';

/// Lightweight result type for domain/application layers.
sealed class Result<T, E> {
  const Result();

  R fold<R>({required R Function(T data) onSuccess, required R Function(E error) onFailure});

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;
}

final class Success<T, E> extends Result<T, E> {
  const Success(this.value);

  final T value;

  @override
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(E error) onFailure,
  }) =>
      onSuccess(value);
}

final class Failure<T, E> extends Result<T, E> {
  const Failure(this.error);

  final E error;

  @override
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(E error) onFailure,
  }) =>
      onFailure(error);
}

/// Application-level failures (network, auth, validation, etc.).
sealed class AppFailure {
  const AppFailure();

  String get message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure(this.message, {this.statusCode, this.cause});

  @override
  final String message;
  final int? statusCode;
  final Object? cause;
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure();

  @override
  String get message => 'Session expired. Please sign in again.';
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(this.message, {this.cause});

  @override
  final String message;
  final Object? cause;
}

extension ApiExceptionToFailure on ApiException {
  AppFailure toAppFailure() => switch (this) {
        ApiTimeoutException(:final message) => NetworkFailure(message, cause: this),
        ApiConnectionException(:final message) => NetworkFailure(message, cause: this),
        ApiUnauthorizedException(:final message) => NetworkFailure(message, statusCode: 401),
        ApiHttpException(:final statusCode, :final message) =>
          NetworkFailure(message, statusCode: statusCode, cause: this),
        ApiUnknownException(:final message, :final cause) => UnknownFailure(message, cause: cause),
      };
}

typedef AppResult<T> = Result<T, AppFailure>;
