# DoctorBridge Mobile — Docs for new developers

Welcome. If you are new to Flutter, read these in order:

1. **[ARCHITECTURE.md](../ARCHITECTURE.md)** (repo root) — folder layout, flavors, how pieces connect.
2. **[riverpod.md](riverpod.md)** — state management: providers, reading state in widgets, adding new providers.
3. **[go-router.md](go-router.md)** — navigation: routes, redirects, role-based access, scaling route tables.
4. **[dio.md](dio.md)** — HTTP: the shared `Dio` client, interceptors, errors, cancel tokens.

**Flutter basics (official):** [flutter.dev/docs](https://docs.flutter.dev/)

**After changing models or `@Riverpod` code**, run code generation:

```bash
cd doctorbridge_mobile_ui
dart run build_runner build --delete-conflicting-outputs
```
