/// Phases for centralized async metadata (aligned with Web `meta.async`).
enum AsyncPhase {
  start,
  fulfilled,
  error,
  reset,
  init,
}
