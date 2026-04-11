// =============================================================================
// dio_interceptors.dart — Dio middleware: auth, errors, optional logging
// =============================================================================
// [AuthInterceptor] adds Bearer token from [TokenStorage] per request.
// [ErrorMappingInterceptor] maps [DioException] to [ApiException] and can
// invoke [onUnauthorized] on 401 (session cleared via SessionController).
// See docs/dio.md.
// =============================================================================

import 'package:dio/dio.dart';

import '../auth/token_storage.dart';
import 'api_exception.dart';
import 'pretty_log_interceptor.dart';

typedef UnauthorizedCallback = void Function();

List<Interceptor> buildDioInterceptors({
  required TokenStorage tokenStorage,
  required bool enableLogging,
  UnauthorizedCallback? onUnauthorized,
}) {
  return [
    AuthInterceptor(tokenStorage: tokenStorage),
    ErrorMappingInterceptor(onUnauthorized: onUnauthorized),
    if (enableLogging) PrettyLogInterceptor(),
  ];
}

final class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
  }) : _tokenStorage = tokenStorage;

  final TokenStorage _tokenStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Converts [DioException] to [ApiException] for upper layers.
final class ErrorMappingInterceptor extends Interceptor {
  ErrorMappingInterceptor({this.onUnauthorized});

  final UnauthorizedCallback? onUnauthorized;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
    }
    final mapped = ApiException.fromDio(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: mapped,
        type: err.type,
        response: err.response,
      ),
    );
  }
}
