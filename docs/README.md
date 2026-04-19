# DoctorBridge Mobile — Docs for new developers

Welcome. If you are new to Flutter, read these in order:

1. **[ARCHITECTURE.md](../ARCHITECTURE.md)** (repo root) — folder layout, flavors, how pieces connect.
2. **[auth-flow.md](auth-flow.md)** — login flow: session vs token, auth vs unauth API calls, diagrams (Dio + Riverpod).
3. **[riverpod.md](riverpod.md)** — state management: providers, reading state in widgets, adding new providers.
4. **[async-architecture.md](async-architecture.md)** — centralized **AsyncTracker**: loading/errors per operation id, parity with Web `state.async`, lifecycle rules, pitfalls.
5. **[async-examples.md](async-examples.md)** — practical examples and cookbook for new API features.
6. **[go-router.md](go-router.md)** — navigation: routes, redirects, role-based access, scaling route tables.
7. **[dio.md](dio.md)** — HTTP: the shared `Dio` client, interceptors, errors, cancel tokens.

**Flutter basics (official):** [flutter.dev/docs](https://docs.flutter.dev/)

**After changing models or `@Riverpod` code**, run code generation:

```bash
cd doctorbridge_mobile_ui
dart run build_runner build --delete-conflicting-outputs
```
