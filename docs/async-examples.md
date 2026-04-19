# AsyncTracker — examples and cookbook

This is the **hands-on** companion to [async-architecture.md](async-architecture.md). It assumes you know what `AsyncTracker` is and focuses on **copy-paste patterns** and **end-to-end examples**.

---

## 1. Minimal pattern (pseudo-code)

Every networked operation should follow the same skeleton:

```dart
final tracker = ref.read(asyncTrackerProvider.notifier);
const op = MyOperationIds.fetchSomething;

tracker.start(op);
try {
  final data = await ref.read(myRepositoryProvider).fetchSomething();
  // Update domain state here (another notifier, session, etc.)
  ref.read(myDataProvider.notifier).setData(data);
  tracker.fulfill(op);
} on MyApiException catch (e) {
  tracker.reportError(op, e.message);
  rethrow; // optional: omit if UI only uses AsyncTracker
} on Object catch (_) {
  tracker.reportError(op, 'Something went wrong');
  rethrow;
}
```

---

## 2. Step 1 — Define operation ids

Create a file so **notifiers and widgets share the same strings**:

```dart
// lib/features/appointments/application/appointment_operation_ids.dart
abstract final class AppointmentOperationIds {
  static const list = 'GET_APPOINTMENTS';
  static const cancel = 'POST_APPOINTMENT_CANCEL';
}
```

**Naming tip:** Align names with REST intent (`GET_*`, `POST_*`) or with Web Redux constants if you share API semantics across repos.

---

## 3. Step 2 — Repository stays “dumb HTTP”

Repositories throw **typed** or **string** errors; they **do not** call `AsyncTracker` (keeps Dio code testable without Riverpod).

```dart
// appointments_repository.dart
Future<List<Appointment>> fetchList() async {
  try {
    final res = await _dio.get<List<dynamic>>('/api/v1/appointments');
    return (res.data ?? [])
        .map((e) => Appointment.fromJson(e as Map<String, dynamic>))
        .toList();
  } on DioException catch (e) {
    throw AppointmentException(_extractMessage(e));
  }
}
```

---

## 4. Step 3 — Notifier orchestrates tracker + repository

```dart
@Riverpod(keepAlive: true)
class AppointmentsNotifier extends _$AppointmentsNotifier {
  @override
  List<Appointment> build() => [];

  Future<void> refresh() async {
    final tracker = ref.read(asyncTrackerProvider.notifier);
    const op = AppointmentOperationIds.list;
    tracker.start(op);
    try {
      final list = await ref.read(appointmentsRepositoryProvider).fetchList();
      state = list;
      tracker.fulfill(op);
    } on AppointmentException catch (e) {
      tracker.reportError(op, e.message);
      rethrow;
    } on Object catch (_) {
      tracker.reportError(op, 'Could not load appointments');
      rethrow;
    }
  }
}
```

---

## 5. Step 4 — Widget: loading + error

```dart
class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const op = AppointmentOperationIds.list;
    final loading = ref.watch(asyncIsFetchingProvider(op));
    final error = ref.watch(asyncErrorProvider(op));
    final rows = ref.watch(appointmentsNotifierProvider);

    if (error != null) {
      return Center(child: Text(error));
    }
    if (loading && rows.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        FilledButton(
          onPressed: loading
              ? null
              : () => ref.read(appointmentsNotifierProvider.notifier).refresh(),
          child: const Text('Refresh'),
        ),
        ...rows.map((a) => ListTile(title: Text(a.title))),
      ],
    );
  }
}
```

---

## 6. SnackBar on error with `ref.listen`

Use **listen** when you want a **one-shot** toast without duplicating error display logic:

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.listen(asyncErrorProvider(AppointmentOperationIds.list), (prev, next) {
    if (next != null && next.isNotEmpty && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next)));
    }
  });
  // ...
}
```

**Tip:** Reset the operation when opening the screen if you must avoid showing a stale error from a previous visit (see login screen for `reset` on first frame).

---

## 7. `fulfilledExtraData` — when to use it

Example: API returns `{ "data": [...], "cached": true }` and you want the UI to show a “served from cache” badge without a separate provider:

```dart
tracker.fulfill(op, fulfilledExtraData: {'cached': response.cached});
```

```dart
final extra = ref.watch(asyncFulfilledExtraDataProvider(op));
final cached = extra is Map && extra['cached'] == true;
```

For **large** or **structured** results, prefer a **dedicated** `StateNotifier` / model in the feature.

---

## 8. Resetting state

### Single operation (e.g. leave screen or switch tab)

```dart
ref.read(asyncTrackerProvider.notifier).reset(AppointmentOperationIds.list);
```

### Everything (rare — e.g. logout)

```dart
ref.read(asyncTrackerProvider.notifier).resetAll();
```

---

## 9. `wasRequested` — empty vs first load

```dart
final requested = ref.watch(asyncWasRequestedProvider(op));
final fetching = ref.watch(asyncIsFetchingProvider(op));
final items = ref.watch(myListProvider);

if (!requested && !fetching) {
  // Never tried — optional auto-fetch in initState / addPostFrameCallback
}
if (requested && items.isEmpty && !fetching) {
  // Truly empty result after a successful run (or handled via domain state)
}
```

---

## 10. Parallel requests with the same operation id

If two calls use the **same** id concurrently, the **last** `start`/`fulfill`/`reportError` wins — buckets are not a queue.

**Auth (`AuthNotifier`)** coalesces in-flight work when inputs **match** (double-tap). If a second call uses **different** phone/password/OTP while the first is still running, it throws a user-visible “please wait” error instead of returning the wrong result.

For other features, either coalesce in the notifier (same pattern), use **different** operation ids (`GET_APPOINTMENTS_LIST` vs `GET_APPOINTMENTS_WIDGET`), or guard with **CancelToken** / a single in-flight flag.

---

## 10b. Stuck `isFetching` and `recoverStuckFetching`

If `start` runs but a bug or refactor skips both `fulfill` and `reportError`, the UI can stay loading forever. Mitigation:

- Prefer **`try` / `catch` / `finally`** and in `finally` call `ref.read(asyncTrackerProvider.notifier).recoverStuckFetching(operationId)` (see `AuthNotifier`).

Also call **`resetAll`** on **logout** so metadata does not leak across users (`SessionController`).

---

## 11. Testing ideas

- **Unit test repository** with mocked `Dio` — no tracker required.
- **Notifier test:** override `asyncTrackerProvider` with a **fake** or spy if you need to assert `start`/`fulfill` order; or test domain state only and treat tracker as implementation detail.
- **Widget test:** pump `ProviderScope`, override repository to succeed/fail, `expect` spinner / error text.

---

## 12. Imports you typically need

```dart
import 'package:doctorbridge_mobile_ui/core/async/async_tracker.dart';
import 'package:doctorbridge_mobile_ui/core/async/async_selectors.dart';
```

Or barrel:

```dart
import 'package:doctorbridge_mobile_ui/core/async/async.dart';
```

---

## 13. Real files to read in this repo

| What | Where |
|------|--------|
| Tracker implementation | `lib/core/async/async_tracker.dart` |
| Selectors | `lib/core/async/async_selectors.dart` |
| Auth operation ids | `lib/features/auth/application/auth_operation_ids.dart` |
| Notifier + Dio + tracker | `lib/features/auth/application/auth_notifier.dart` |
| UI wiring | `lib/features/auth/presentation/login/login_screen.dart` |
