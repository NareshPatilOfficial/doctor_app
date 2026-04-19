import 'dart:convert';

/// Web `base64Encode(password)` uses UTF-8 bytes then base64 (same as `btoa` for ASCII).
String encodePasswordAsBase64(String password) {
  return base64Encode(utf8.encode(password));
}
