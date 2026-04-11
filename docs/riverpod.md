# Riverpod in this project

[Riverpod](https://riverpod.dev/) manages **state** and **dependency injection** in DoctorBridge. The app uses **flutter_riverpod** in the UI and **riverpod_annotation** + **riverpod_generator** for typed providers.

## Mental model (beginner)

- A **provider** is a named recipe for a value or service (config, `Dio`, auth session, repositories).
- Widgets that need data use **`ConsumerWidget`** (or `Consumer`) and call **`ref.watch(someProvider)`** to rebuild when that data changes.
- One-off actions use **`ref.read(someProvider.notifier).someMethod()`** (for example login or logout).

**Rule of thumb:** `watch` in `build` for UI; `read` inside callbacks (button taps, interceptors) to avoid unnecessary rebuilds.

## What we already wired

| Provider | File | Purpose |
|----------|------|---------|
| `appConfigProvider` | `lib/core/config/app_config.dart` | Environment: `baseUrl`, logging, mock auth. **Overridden** in `main.dart` / `main_*.dart`. |
| `tokenStorageProvider` | `lib/core/auth/token_storage.dart` | Secure storage for tokens + cached user JSON. |
| `sessionControllerProvider` | `lib/core/auth/session_controller.dart` | Auth state: load session, mock login, logout, 401 handling. |
| `dioProvider` | `lib/core/network/dio_provider.dart` | Single HTTP client (depends on config + session behavior via interceptors). |
| `routerProvider` | `lib/core/routing/app_router.dart` | `GoRouter`; listens to session and refreshes redirects. |

## How `ProviderScope` and overrides work

At startup (`main.dart`), we wrap the app:

```dart
runApp(
  ProviderScope(
    overrides: [
      appConfigProvider.overrideWithValue(const AppConfig(...)),
    ],
    child: const App(),
  ),
);
```

That **replaces** the default `appConfigProvider` (which would throw if not overridden) with the real config for **dev / stage / prod**. New developers: **never** hard-code API URLs in a feature; always read `ref.watch(appConfigProvider)`.

## Adding a new `@Riverpod` provider (scalable pattern)

1. Create a Dart file (for example `lib/features/appointments/data/appointments_repository_providers.dart`).
2. Declare the provider with annotations:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/dio_provider.dart';

part 'appointments_repository_providers.g.dart';

@Riverpod(keepAlive: true)
AppointmentsRepository appointmentsRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AppointmentsRepositoryImpl(dio);
}
```

3. Run **`dart run build_runner build --delete-conflicting-outputs`**.
4. In UI or notifiers, use `ref.watch(appointmentsRepositoryProvider)`.

**Scalability:** each feature can own its `*_providers.dart` files. Repositories take `Dio` (or other providers) via `ref.watch`, so you rarely edit global wiring when adding features.

## `AsyncNotifier` (session example)

`SessionController` extends generated `_$SessionController` and implements `build()` that returns `Future<AuthState>`. The **session** is exposed as `AsyncValue<AuthState>`:

- **Loading** — session is restoring from secure storage.
- **Data** — user is signed in or signed out.
- **Error** — rare; router sends user to login.

UI and router use `session.when(...)` or `ref.watch(sessionControllerProvider)`.

## Testing and overrides

In tests, override the same providers:

```dart
ProviderScope(
  overrides: [
    appConfigProvider.overrideWithValue(testConfig),
  ],
  child: const App(),
);
```

See `test/widget_test.dart` for a minimal example.

## Further reading

- [Riverpod: Getting started](https://riverpod.dev/docs/getting_started)
- [Code generation (riverpod_generator)](https://riverpod.dev/docs/concepts/about_code_generation)
