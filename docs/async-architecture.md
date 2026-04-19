# Centralized async architecture (AsyncTracker)

This document explains **why** and **how** DoctorBridge Mobile tracks API and async work in one place (`AsyncTracker`), how it relates to the **Web DoctorBridge Redux `state.async`** pattern, and where **domain state** (users, lists, tokens) should live instead.

**Companion:** [async-examples.md](async-examples.md) — step-by-step examples and copy-paste recipes.

---

## 1. Problem we are solving

Without a shared pattern, each screen tends to invent its own:

- `bool _loading`
- `String? _error`
- ad-hoc SnackBars and spinners

That works for one screen but becomes inconsistent: different error shapes, forgotten loading flags, and no single place to observe “what is the app doing right now?” for a given **operation**.

**AsyncTracker** holds **only lifecycle metadata** for named **operations** (string ids). Business data (doctor profile, appointments, session) stays in **feature notifiers**, repositories, or other providers — not inside the async map.

---

## 2. Mental model in one diagram

```text
┌─────────────────────────────────────────────────────────────────┐
│  UI (ConsumerWidget)                                             │
│  ref.watch(asyncIsFetchingProvider('GET_APPOINTMENTS'))         │
│  ref.watch(asyncErrorProvider('GET_APPOINTMENTS'))                │
└────────────────────────────┬──────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│  asyncTrackerProvider  →  Map<operationId, AsyncOpState>         │
│  isFetching / wasRequested / error / fulfilledExtraData          │
└────────────────────────────┬──────────────────────────────────────┘
                             ▲
                             │ start / fulfill / reportError / reset
┌────────────────────────────┴──────────────────────────────────────┐
│  Feature @Riverpod Notifier (or repository wrapper)              │
│  start → await dio / repository → fulfill | reportError           │
└────────────────────────────┬──────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│  Domain state (elsewhere)                                        │
│  e.g. sessionControllerProvider, feature-specific Notifiers      │
└─────────────────────────────────────────────────────────────────┘
```

**Rule:** AsyncTracker answers: *“Is this request in flight? Did it fail? What was the last outcome?”*  
It does **not** answer: *“What is the list of appointments?”* — that belongs in a feature-level state.

---

## 3. Parity with Web Redux `state.async`

The Web app uses a **single global slice** keyed by **action type string** (e.g. `GET_DOCTOR_DATA`), with phases carried in `meta.async` instead of five separate Redux type strings.

| Web | Mobile (this repo) |
|-----|---------------------|
| `state.async[T]` | `asyncTrackerProvider` → `Map` entry for `T` |
| `meta.async === START` | `AsyncTracker.start(operationId)` |
| `meta.async === FULFILLED` | `AsyncTracker.fulfill(operationId, fulfilledExtraData: …)` |
| `meta.async === ERROR` | `AsyncTracker.reportError(operationId, message)` |
| `meta.async === RESET` | `AsyncTracker.reset(operationId)` |
| `RESET_ALL` | `AsyncTracker.resetAll()` |
| Selectors (`asyncIsFetching`, …) | `asyncIsFetchingProvider(operationId)`, etc. |

Operation ids should be **stable strings** shared by notifiers and UI — same idea as exporting a constant like `GET_DOCTOR_DATA` on Web.

---

## 4. State shape: `AsyncOpState`

Each **operation id** maps to one bucket (if missing, selectors treat flags as “empty”):

| Field | Meaning |
|--------|---------|
| `isFetching` | Request is in progress (spinner, disable button). |
| `wasRequested` | At least one attempt has been made (useful for “show empty vs loading” UX). |
| `error` | Human-readable message for UI (from API or fallback). |
| `fulfilledExtraData` | Optional payload for rare cases (Web used `true` as default when no extra). |

Defined in: `lib/core/async/async_op_state.dart`.

---

## 5. Lifecycle rules (what each method does)

Implementation: `lib/core/async/async_tracker.dart`.

### `start(operationId)`

- **Replaces** the bucket for this id with:
  - `isFetching: true`
  - `wasRequested: true`
  - `error: null`
  - `fulfilledExtraData: null`
- Call this **immediately before** `await`ing network work (or at the very start of the async method).

### `fulfill(operationId, { fulfilledExtraData })`

- Ensures a bucket exists.
- Sets `isFetching: false`, `wasRequested: true`, `error: null`.
- Sets `fulfilledExtraData` to the argument, or **`true`** if omitted (aligned with Web default).

### `reportError(operationId, message)`

- Sets `isFetching: false`, `wasRequested: true`, `error: message`.

### `reset(operationId)`

- **Removes** the key — as if the operation never ran (selectors return defaults).

### `resetAll()`

- Clears the **entire** map.

### `AsyncPhase` enum (`async_phase.dart`)

We keep **`AsyncPhase`** for documentation and future extensions (e.g. logging). The tracker methods above are the **source of truth** for transitions; there is no separate “INIT” transition in the tracker today (similar to Web where INIT may not mutate `state.async` unless you add it).

---

## 6. Selectors (Riverpod “selector” providers)

Generated-style providers in `lib/core/async/async_selectors.dart`:

| Provider | Use |
|----------|-----|
| `asyncIsFetchingProvider(id)` | Button spinner, disable inputs. |
| `asyncWasRequestedProvider(id)` | Distinguish “never loaded” vs “loaded once”. |
| `asyncErrorProvider(id)` | Inline error text or SnackBar via `ref.listen`. |
| `asyncStateProvider(id)` | Full `AsyncOpState?` bucket. |
| `asyncFulfilledExtraDataProvider(id)` | Optional metadata after success. |

**Important:** The **`id`** must be the **same string** you pass to `start` / `fulfill` / `reportError` — typically a constant from a feature file such as `AuthOperationIds` (`lib/features/auth/application/auth_operation_ids.dart`).

---

## 7. Where Dio fits

**Dio does not talk to AsyncTracker by itself** in our default pattern. The **orchestration** is:

1. Notifier (or service) calls `start`.
2. Notifier uses **`AuthRepository` / `Dio`** (via `dioProvider`) to perform HTTP.
3. On success: update **session or domain state**, then `fulfill`.
4. On failure: `reportError` with a string users can read.

Optional advanced pattern: a Dio **interceptor** that reads `RequestOptions.extra['operationId']` and calls `start`/`fulfill`/`reportError`. That reduces duplication but requires **every** request to set `operationId` consistently — we document the explicit notifier pattern first.

---

## 8. Feature folder layout (scalable)

Recommended layout for a feature that calls an API:

```text
lib/features/<feature>/
  application/
    <feature>_operation_ids.dart   # const operation id strings
    <feature>_notifier.dart        # @Riverpod: orchestrates tracker + repository
  data/
    <feature>_repository.dart      # Dio calls, parsing, throws typed errors
  presentation/
    <screen>.dart                  # ref.watch selectors; ref.read notifier
```

**Root wiring:** `dioProvider` stays in `core/network/`; repositories receive `Dio` through Riverpod — no duplicate HTTP clients.

---

## 9. Auth feature (reference implementation)

The login flow uses:

- `AuthOperationIds.loginWithPassword` → `POST_AUTH_LOGIN`
- `AuthOperationIds.sendPatientOtp` → `POST_AUTH_SEND_OTP`
- `AuthOperationIds.patientLoginWithOtp` → `POST_AUTH_PATIENT_LOGIN`

`AuthNotifier` wraps each repository call with `AsyncTracker`. The login screen watches `asyncIsFetchingProvider` and `asyncErrorProvider` for UX.

See: `lib/features/auth/application/auth_notifier.dart`, `lib/features/auth/presentation/login/login_screen.dart`.

---

## 10. Production hardening (this repo)

These guardrails keep async metadata consistent under failures, double-taps, and session changes:

| Mechanism | Purpose |
|-----------|---------|
| **`recoverStuckFetching`** (`AsyncTracker`) | Call from a `finally` after `start` if a future code path could skip both `fulfill` and `reportError`. Clears a stuck `isFetching: true` with a fallback message. |
| **Non-empty `operationId`** | `start` / `fulfill` / `reportError` / `reset` throw [ArgumentError] if the id is `''`, catching typos early. |
| **In-flight coalescing** (`AuthNotifier`) | Duplicate calls with the **same** inputs await the same `Future` (double-tap). Concurrent calls with **different** inputs throw a short “please wait” [AuthRepositoryException] so results are never mixed up. |
| **`resetAll` on logout** (`SessionController`) | Clears all async buckets so the next user does not inherit loading/error flags from the previous session. |
| **Login screen mount** | Resets password + OTP operation ids on first frame so stale errors do not flash SnackBars or inline text. |

**Scalability:** the tracker map grows with distinct operation ids. Call **`reset`** when leaving a flow or **`resetAll`** on logout / account switch. Avoid unbounded unique ids (e.g. per-row UUIDs as keys) unless you also remove keys when done.

---

## 11. Common pitfalls

1. **Mismatched ids** — Typo between notifier and widget breaks updates. **Always** use shared `const` strings from `*_operation_ids.dart`.
2. **Forgetting `fulfill` or `reportError`** — Request can stay `isFetching: true` forever. Use **`try` / `catch` / `finally`** and **`recoverStuckFetching`** in `finally` for notifiers that call `start` (see `AuthNotifier`).
3. **Putting large domain payloads in `fulfilledExtraData`** — Prefer storing results in a feature notifier; use `fulfilledExtraData` only when you need a small cross-cutting marker.
4. **SnackBar + `ref.listen` on every rebuild** — Listen in `build` is valid in Riverpod, but guard with `if (next != null && next.isNotEmpty)` and **reset** stale operation state when opening a screen (login resets all auth operation ids on mount).
5. **Using `dart test` on Flutter projects** — Use **`flutter test`** for widget/integration tests; plain `dart test` may fail on `dart:ui`.

---

## 12. File map

| File | Role |
|------|------|
| `lib/core/async/async_phase.dart` | `AsyncPhase` enum (documentation / future use). |
| `lib/core/async/async_op_state.dart` | Freezed `AsyncOpState`. |
| `lib/core/async/async_tracker.dart` | `AsyncTracker` + `asyncTrackerProvider`. |
| `lib/core/async/async_selectors.dart` | Selector family providers. |
| `lib/core/async/async.dart` | Barrel export. |

After editing annotated files, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 13. Further reading

- [riverpod.md](riverpod.md) — providers, `watch` vs `read`.
- [dio.md](dio.md) — shared client, errors.
- [auth-flow.md](auth-flow.md) — session and login from a routing/security angle.
