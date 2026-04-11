// =============================================================================
// context_extensions.dart — Small BuildContext helpers
// =============================================================================
// Shared UI conveniences. Add more extensions here only if used in 2+ features.
// =============================================================================

import 'package:flutter/widgets.dart';

extension BuildContextX on BuildContext {
  void unfocusKeyboard() => FocusScope.of(this).unfocus();
}
