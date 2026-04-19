import 'package:doctorbridge_mobile_ui/core/utils/password_encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UTF-8 password base64 matches web btoa for ASCII', () {
    expect(encodePasswordAsBase64('secret'), 'c2VjcmV0');
    expect(encodePasswordAsBase64('password123'), 'cGFzc3dvcmQxMjM=');
  });
}
