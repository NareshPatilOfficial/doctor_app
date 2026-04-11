# go_router in this project

[go_router](https://pub.dev/packages/go_router) handles **URLs**, **navigation stack**, and **redirects**. It fits well with **Riverpod** when the router **listens** to auth changes and re-runs guards.

## Where it lives

- **`lib/core/routing/route_paths.dart`** — string constants for every path (avoid typos).
- **`lib/core/routing/app_router.dart`** — `GoRouter` + `redirect` logic + list of `GoRoute`s.
- **`lib/core/routing/role_route_extension.dart`** — maps `UserRole` → home path and `/admin`, `/doctor`, etc.

## Beginner: navigation in widgets

Use the **`BuildContext`** extension from go_router:

```dart
context.go(RoutePaths.patientProfile);      // replace stack (common for shells)
context.push(RoutePaths.patientProfile);   // push a detail on top
context.pop();                             // go back
```

Import: `package:go_router/go_router.dart`.

## Public vs role routes

- **Public:** `/splash`, `/login` — reachable without a full session (splash while loading).
- **Role branches:** `/admin/...`, `/doctor/...`, `/staff/...`, `/patient/...`, `/chemist/...` — only the matching `UserRole` should stay there; others are redirected home.

Staff (receptionist) uses path prefix **`/staff`**; the enum value is still **`UserRole.staff`**.

## How redirects work here

`routerProvider` builds a `GoRouter` with:

1. **`refreshListenable`** — a `ValueNotifier` bumped whenever `sessionControllerProvider` changes, so redirects run again after login/logout.
2. **`redirect`** — reads `AsyncValue<AuthState>`:
   - **Session loading** → keep user on **`/splash`** (or send others to splash).
   - **Signed out** → **`/login`** (except already on login).
   - **Signed in** → if on splash/login, send to **role home**; if URL does not match role prefix, **send to role home**.

Helper: `roleAllowsPath(role, location)` in `role_route_extension.dart`.

## Adding a new screen (scalable checklist)

1. Add a constant in **`route_paths.dart`** (for example `static const doctorNotes = '/doctor/notes';`).
2. Create the widget under **`lib/features/.../presentation/`**.
3. Register **`GoRoute(path: RoutePaths.doctorNotes, builder: ...)`** in **`app_router.dart`**.
4. If the screen belongs to one role only, **no extra redirect code** is needed if the path starts with that role’s prefix (for example `/doctor/`).

## Scaling large route tables

When `app_router.dart` grows:

- **Split** route lists by role: `admin_routes.dart`, `doctor_routes.dart`, etc., each exposing `List<RouteBase> get doctorRoutes => [...]`.
- Import and spread into the main `routes: [...]` list.
- Optionally use **`ShellRoute`** or **`StatefulShellRoute`** for tab bars per role (not required for the current scaffold).

## Deep links and path parameters (future)

go_router supports `/doctor/appointments/:id`. When you add IDs:

1. Use `path: '/doctor/appointments/:id'`.
2. Read `state.pathParameters['id']` in the `builder`.

Keep path templates in `route_paths.dart` as documentation or use small helper functions.

## Further reading

- [go_router — Navigation](https://pub.dev/documentation/go_router/latest/topics/Navigation-topic.html)
- [go_router — Redirection](https://pub.dev/documentation/go_router/latest/topics/Redirection-topic.html)
