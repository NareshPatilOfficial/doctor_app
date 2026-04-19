/// India mobile: digits only, last 10 digits, `+91` prefix for API.
abstract final class PhoneUtils {
  static String digitsOnly(String input) => input.replaceAll(RegExp(r'\D'), '');

  /// Returns 10-digit local number or null if invalid.
  static String? stripToTenDigits(String input) {
    final digits = digitsOnly(input);
    if (digits.length >= 10) {
      return digits.substring(digits.length - 10);
    }
    if (digits.length == 10) {
      return digits;
    }
    return null;
  }

  /// API format matching web: `+91` + 10 digits.
  static String toIndiaE164(String tenDigits) => '+91$tenDigits';
}
