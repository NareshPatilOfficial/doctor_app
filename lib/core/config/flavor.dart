// =============================================================================
// flavor.dart — Build environment label (dev / stage / prod)
// =============================================================================
// Used by [AppConfig] and entrypoints. Does not select Dart compile mode by
// itself; pair with Android product flavors and iOS schemes. See ARCHITECTURE.md.
// =============================================================================

enum Flavor {
  dev,
  stage,
  prod,
}
