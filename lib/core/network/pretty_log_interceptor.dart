// =============================================================================
// pretty_log_interceptor.dart — Lightweight Dio request/response logs
// =============================================================================
// Only active when [AppConfig.enableNetworkLogging] is true. Avoid logging
// full response bodies in production (PHI). See docs/dio.md.
// =============================================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dev-only logging; keep logs small and avoid bodies with PHI.
final class PrettyLogInterceptor extends Interceptor {
  PrettyLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('--> ${options.method} ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('<-- ${response.statusCode} ${response.requestOptions.uri}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('*** DioError ${err.requestOptions.uri}: ${err.message}');
    }
    handler.next(err);
  }
}
