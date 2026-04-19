// =============================================================================
// route_paths.dart — Canonical URL path strings for go_router
// =============================================================================
// Use these constants in GoRoute(path: ...) and context.go(...) to avoid typos.
// Role prefixes mirror the web app mental model; staff uses /staff.
// =============================================================================

/// Central route path constants.
///
/// **Web mental model mapping**
/// - `/admin` — admin (onboard, dashboard)
/// - `/doctor` — doctor workspace (appointments, patients, planner, etc.)
/// - `/staff` — receptionist / front desk (queue, booking)
/// - `/patient` — patient (appointments, booking, profile)
/// - `/chemist` — chemist (prescriptions)
abstract final class RoutePaths {
  static const splash = '/splash';
  static const login = '/login';

  static const admin = '/admin';
  static const adminDashboard = '/admin/dashboard';
  static const adminOnboard = '/admin/onboard';

  static const doctor = '/doctor';
  static const doctorDashboard = '/doctor/dashboard';
  static const doctorPatients = '/doctor/patients';
  static const doctorAppointments = '/doctor/appointments';
  static const doctorAppointmentDetail = '/doctor/appointments/detail';
  static const doctorMedicalReport = '/doctor/medical-report';
  static const doctorConfiguration = '/doctor/configuration';
  static const doctorPlanner = '/doctor/planner';
  static const doctorPreviewReport = '/doctor/preview-report';

  /// Receptionist / staff (matches “staff” role in app; path is `/staff`).
  static const staff = '/staff';
  static const staffDashboard = '/staff/dashboard';
  static const staffAppointments = '/staff/appointments';
  static const staffQueue = '/staff/queue';
  static const staffOnboardPatient = '/staff/onboard-patient';

  static const patient = '/patient';
  static const patientAppointments = '/patient/appointments';
  static const patientBook = '/patient/book';
  /// Web `patientBookAppointmentViaLink` segment (book via deep link).
  static const patientBookAppointmentViaLink = '/patient/patientBookAppointmentViaLink';
  static const patientProfile = '/patient/profile';

  /// Query on `/login` for post-auth redirect (patient deep link).
  static const returnUrlQueryParam = 'returnUrl';

  static const chemist = '/chemist';
  static const chemistDashboard = '/chemist/dashboard';
  static const chemistPrescriptions = '/chemist/prescriptions';
}
