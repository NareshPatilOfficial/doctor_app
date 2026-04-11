# Dio (HTTP) in this project

[Dio](https://pub.dev/packages/dio) is the HTTP client. This app uses **one shared `Dio` instance** from **`dioProvider`** so timeouts, base URL, and interceptors stay consistent.

## Where it lives

| Piece | File | Role |
|-------|------|------|
| `dioProvider` | `lib/core/network/dio_provider.dart` | Builds `Dio` with `BaseOptions` from `AppConfig`. |
| Interceptors | `lib/core/network/dio_interceptors.dart` | Auth header, error mapping, optional logging. |
| Dev logging | `lib/core/network/pretty_log_interceptor.dart` | Small debug prints (no full PHI bodies). |
| Typed errors | `lib/core/network/api_exception.dart` | `ApiException.fromDio(...)` hierarchy. |

## Beginner: making a request

**Do not** create `Dio()` in a widget. Inject via Riverpod:

```dart
final dio = ref.watch(dioProvider);
final response = await dio.get<Map<String, dynamic>>('/v1/appointments');
```

Base URL is already set (`AppConfig.baseUrl`), so paths are usually **relative** (for example `/v1/...`).

## Authorization header

`AuthInterceptor` reads the access token from **`TokenStorage`** on each request and sets:

`Authorization: Bearer <token>`

So after real login, persist the token with `TokenStorage.persistSession(...)`; Dio picks it up automatically.

## Errors: `DioException` → `ApiException`

`ErrorMappingInterceptor` turns failures into a **`DioException`** whose **`error`** field holds an **`ApiException`** subclass (timeout, HTTP error, etc.).

In repositories, you can normalize further to **`AppFailure`** / **`Result`** using `toAppFailure()` in `lib/core/utils/result.dart`.

## 401 and logout

On **401**, the interceptor triggers **`logoutOnUnauthorized`** on **`SessionController`**, which clears storage and marks the user signed out. The router then sends the user to **login**.

## Cancel tokens (long requests)

Dio supports **`CancelToken`**. In a notifier or repository method:

```dart
final cancelToken = CancelToken();

// pass to request
await dio.get('/v1/heavy-report', cancelToken: cancelToken);

// when user leaves screen or taps cancel:
cancelToken.cancel();
```

**Scalable pattern:** store `CancelToken?` on an `AsyncNotifier`, cancel in `ref.onDispose` when the provider is disposed.

## Logging and production

`AppConfig.enableNetworkLogging` adds **`PrettyLogInterceptor`** in **debug-style** setups. For production, set **`enableNetworkLogging: false`** (see `main_prod.dart`) and avoid logging sensitive health data.

## Testing without a real API

- Point **`baseUrl`** at a mock server or stub.
- Or override **`dioProvider`** in tests with a `Dio` instance that uses `InterceptorsWrapper` to return fake responses.

## Further reading

- [Dio documentation](https://pub.dev/documentation/dio/latest/dio/dio-library.html)
- [CancelToken](https://pub.dev/documentation/dio/latest/dio/CancelToken-class.html)
