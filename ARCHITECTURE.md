# DoctorBridge Mobile — Architecture

This document is the **high-level map** of the Flutter app. For **step-by-step guides** aimed at new Flutter developers, start with **[docs/README.md](docs/README.md)** and the topic pages:

| Topic | Doc |
|--------|-----|
| Auth, session, tokens, login + Dio flow | [docs/auth-flow.md](docs/auth-flow.md) |
| Riverpod (state, providers, overrides) | [docs/riverpod.md](docs/riverpod.md) |
| go_router (navigation, redirects, scaling) | [docs/go-router.md](docs/go-router.md) |
| Dio (HTTP, interceptors, cancel tokens) | [docs/dio.md](docs/dio.md) |

---

## What this app is

**DoctorBridge** is a multi-role clinic app: **admin**, **doctor**, **staff** (receptionist), **patient**, and **chemist**. Each role uses different routes under a path prefix (for example `/doctor/...`, `/staff/...`).

The codebase is **feature-first**: new work usually adds folders under `lib/features/<feature>/` plus routes and providers, without rewriting unrelated modules.

---

## Folder layout (`lib/`)

| Path | Responsibility |
|------|----------------|
| `app/` | App shell: `bootstrap()` (startup), `App` widget (`MaterialApp.router`). |
| `core/config/` | `Flavor`, `AppConfig`, `appConfigProvider` (overridden per environment). |
| `core/network/` | Shared `Dio`, interceptors, `ApiException` types. |
| `core/auth/` | Tokens, session (`AuthState`, `User`, `SessionController`). |
| `core/routing/` | `GoRouter`, path constants, role → route helpers. |
| `core/theme/` | `ThemeData` for the whole app. |
| `core/utils/` | Cross-cutting types like `Result` / `AppFailure`. |
| `features/` | Product areas (auth, admin, doctor, receptionist, patient, chemist). |
| `shared/` | Reusable widgets and extensions not tied to one feature. |
| `main.dart`, `main_*.dart` | Entrypoints; each sets `AppConfig` and runs `ProviderScope` + `App`. |

Generated files (`*.g.dart`, `*.freezed.dart`) are produced by **build_runner**; do not edit them by hand.

---

## Provider graph (how wiring fits together)

- **`appConfigProvider`** — Injected per flavor in `main_*.dart` via `ProviderScope` overrides. Holds `baseUrl`, logging flags, and mock-auth toggles. **Do not hard-code API URLs in features**; use `ref.watch(appConfigProvider)`.
- **`tokenStorageProvider`** — `TokenStorage` backed by `flutter_secure_storage` (access token, optional refresh, cached user JSON for bootstrap).
- **`sessionControllerProvider`** — `AsyncNotifier<AuthState>`: restores session from storage, mock login/logout until real auth exists, used by routing and Dio 401 handling.
- **`dioProvider`** — Single configured `Dio`: timeouts and `baseUrl` from config; interceptors attach `Authorization`, map errors to `ApiException`, optional dev logging, and trigger `logoutOnUnauthorized` on 401.
- **`routerProvider`** — `GoRouter` with `refreshListenable` tied to session changes; redirects enforce public routes, loading/splash, and role-scoped branches.

**Typical feature data flow:** `appConfig` + `dio` → **repository** (data) → **notifier / use-case** (application) → **widgets** (presentation). Keep **domain** interfaces free of Flutter imports.

---

## Roles and routes

| App role | Route prefix | Notes |
|----------|--------------|--------|
| Admin | `/admin` | Onboard, dashboard |
| Doctor | `/doctor` | Appointments, patients, planner, configuration, reports |
| Staff (receptionist) | `/staff` | Queue, booking, onboard patient |
| Patient | `/patient` | Appointments, book, profile |
| Chemist | `/chemist` | Prescriptions |

Paths live in **`lib/core/routing/route_paths.dart`**. The **staff** role uses **`/staff`** in URLs while the enum remains **`UserRole.staff`**.

---

## Adding a new feature (checklist)

1. Add `lib/features/<name>/` with `data/`, `domain/`, `presentation/` (or `application/`) as needed.
2. Define **repository interfaces** and entities in `domain/` without importing Flutter or Dio.
3. Implement repositories in `data/`; expose Riverpod providers from `data/*_providers.dart` using `dioProvider` (and map errors to `AppFailure` / `Result` at the edges).
4. Add path constants to `route_paths.dart` and `GoRoute`s to `app_router.dart` (or a split route file imported there).
5. **Do not** import `presentation` from `data` or `domain`.

---

## Flavors and run commands

| Environment | Entrypoint | Example |
|-------------|------------|---------|
| Dev (default `main.dart`) | `lib/main.dart` or `lib/main_dev.dart` | `flutter run --flavor dev -t lib/main_dev.dart` |
| Stage | `lib/main_stage.dart` | `flutter run --flavor stage -t lib/main_stage.dart` |
| Production | `lib/main_prod.dart` | `flutter run --flavor prod -t lib/main_prod.dart` |

**Android:** product flavors `dev`, `stage`, `prod` are in `android/app/build.gradle.kts` (with `applicationIdSuffix` for non-prod).

**iOS:** add Xcode schemes that mirror those flavors and point to the matching `-t lib/main_<flavor>.dart`; use distinct bundle IDs per environment for release.

---

## Code generation

After editing `@freezed`, `json_serializable`, or `@Riverpod` types:

```bash
dart run build_runner build --delete-conflicting-outputs
```


flowchart TD
  A[App starts main.dart] --> B[ProviderScope + AppConfig]
  B --> C[SessionController.build]
  C --> D{Token in SecureStorage?}
  D -->|No| E[AuthState.unauthenticated]
  D -->|Yes| F{User JSON valid?}
  F -->|No| G[clearSession]
  G --> E
  F -->|Yes| H[AuthState.authenticated]
  E --> I[GoRouter redirect → /login]
  H --> J[GoRouter redirect → role home]

