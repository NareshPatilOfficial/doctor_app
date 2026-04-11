// =============================================================================
// api_exception.dart — Domain-friendly HTTP errors
// =============================================================================
// Map [DioException] to sealed [ApiException] types so repositories and UI can
// switch on timeout vs HTTP vs unknown. Pair with [AppFailure] in result.dart.
// =============================================================================

import 'package:dio/dio.dart';

/// Typed failures mapped from [DioException] for consistent error handling.
sealed class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => 'ApiException: $message';

  static ApiException fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiTimeoutException(e.message ?? 'Request timed out');
      case DioExceptionType.connectionError:
        return ApiConnectionException(e.message ?? 'Connection error');
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        final data = e.response?.data;
        final msg = _messageFromResponse(data) ?? e.message ?? 'Request failed';
        if (status == 401) {
          return ApiUnauthorizedException(msg);
        }
        return ApiHttpException(statusCode: status ?? 0, message: msg);
      case DioExceptionType.cancel:
        return ApiUnknownException('Request cancelled', cause: e);
      case DioExceptionType.badCertificate:
        return ApiConnectionException(e.message ?? 'Bad certificate');
      case DioExceptionType.unknown:
        return ApiUnknownException(e.message ?? 'Unknown error', cause: e);
    }
  }

  static String? _messageFromResponse(Object? data) {
    if (data is Map<String, dynamic>) {
      final m = data['message'];
      if (m is String) {
        return m;
      }
      final err = data['error'];
      if (err is String) {
        return err;
      }
    }
    return null;
  }
}

final class ApiTimeoutException extends ApiException {
  const ApiTimeoutException(super.message);
}

final class ApiConnectionException extends ApiException {
  const ApiConnectionException(super.message);
}

final class ApiUnauthorizedException extends ApiException {
  const ApiUnauthorizedException(super.message);
}

final class ApiHttpException extends ApiException {
  const ApiHttpException({required this.statusCode, required String message}) : super(message);

  final int statusCode;
}

final class ApiUnknownException extends ApiException {
  const ApiUnknownException(super.message, {this.cause});

  final Object? cause;
}
