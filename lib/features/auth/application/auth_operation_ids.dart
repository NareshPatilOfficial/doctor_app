/// Operation ids for [AsyncTracker] — match API intent; stable across UI and notifiers.
abstract final class AuthOperationIds {
  static const loginWithPassword = 'POST_AUTH_LOGIN';
  static const sendPatientOtp = 'POST_AUTH_SEND_OTP';
  static const patientLoginWithOtp = 'POST_AUTH_PATIENT_LOGIN';
}
