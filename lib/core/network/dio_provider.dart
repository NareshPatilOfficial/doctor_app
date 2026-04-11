// =============================================================================
// dio_provider.dart — Single shared HTTP client (Riverpod)
// =============================================================================
// Exposes [dioProvider]: one [Dio] per app with baseUrl/timeouts from
// [appConfigProvider], auth header from [tokenStorageProvider], and interceptors
// from [buildDioInterceptors]. Repositories should ref.watch(dioProvider), not
// construct Dio in widgets. See docs/dio.md.
// =============================================================================

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/session_controller.dart';
import '../auth/token_storage.dart';
import '../config/app_config.dart';
import 'dio_interceptors.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);

  final client = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  client.interceptors.addAll(
    buildDioInterceptors(
      tokenStorage: tokenStorage,
      enableLogging: config.enableNetworkLogging,
      onUnauthorized: () {
        unawaited(
          ref.read(sessionControllerProvider.notifier).logoutOnUnauthorized(),
        );
      },
    ),
  );

  return client;
}
