// =============================================================================
// app_router.dart — GoRouter + Riverpod ([routerProvider])
// =============================================================================
// Declares all [GoRoute]s, session-based [redirect], and refreshListenable tied
// to [sessionControllerProvider]. Add new screens here or split route lists by
// role in separate files. See docs/go-router.md.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/admin_onboard_screen.dart';
import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/chemist/dashboard/chemist_dashboard_screen.dart';
import '../../features/chemist/prescriptions/chemist_prescriptions_screen.dart';
import '../../features/doctor/appointment_detail/doctor_appointment_detail_screen.dart';
import '../../features/doctor/appointments/doctor_appointments_screen.dart';
import '../../features/doctor/configuration/doctor_configuration_screen.dart';
import '../../features/doctor/dashboard/doctor_dashboard_screen.dart';
import '../../features/doctor/medical_report/doctor_medical_report_screen.dart';
import '../../features/doctor/patients/doctor_patients_screen.dart';
import '../../features/doctor/planner/doctor_planner_screen.dart';
import '../../features/doctor/preview_report/doctor_preview_report_screen.dart';
import '../../features/patient/appointments/patient_appointments_screen.dart';
import '../../features/patient/book_appointment/patient_book_appointment_screen.dart';
import '../../features/patient/book_via_link/patient_book_via_link_screen.dart';
import '../../features/patient/presentation/switch_user/patient_switch_user_screen.dart';
import '../../features/patient/profile/patient_profile_screen.dart';
import '../../features/receptionist/appointments/receptionist_appointments_screen.dart';
import '../../features/receptionist/dashboard/receptionist_dashboard_screen.dart';
import '../../features/receptionist/onboard_patient/receptionist_onboard_patient_screen.dart';
import '../../features/receptionist/patient_queue/receptionist_patient_queue_screen.dart';
import '../auth/auth_state.dart';
import '../auth/session_controller.dart';
import '../auth/user.dart';
import 'role_route_extension.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

bool _safePatientReturnPath(String path) {
  return path.startsWith('${RoutePaths.patient}/') || path == RoutePaths.patient;
}

String? _redirectForSession({
  required Ref ref,
  required AsyncValue<AuthState> session,
  required String location,
  required GoRouterState state,
}) {
  return session.when(
    loading: () {
      if (location == RoutePaths.splash) {
        return null;
      }
      return RoutePaths.splash;
    },
    error: (error, stackTrace) => RoutePaths.login,
    data: (auth) {
      return auth.when(
        unauthenticated: () => location == RoutePaths.login ? null : RoutePaths.login,
        authenticated: (user) {
          if (location == RoutePaths.login) {
            final pending = ref.read(sessionControllerProvider.notifier).takePendingPostLoginPath();
            if (pending != null &&
                pending.isNotEmpty &&
                user.role == UserRole.patient &&
                _safePatientReturnPath(pending)) {
              return pending;
            }
            final q = state.uri.queryParameters[RoutePaths.returnUrlQueryParam];
            if (q != null && q.isNotEmpty && user.role == UserRole.patient) {
              final decoded = Uri.decodeComponent(q);
              if (_safePatientReturnPath(decoded)) {
                return decoded;
              }
            }
            return user.role.homePath;
          }
          if (location == RoutePaths.splash) {
            return user.role.homePath;
          }
          if (!roleAllowsPath(user.role, location)) {
            return user.role.homePath;
          }
          return null;
        },
      );
    },
  );
}

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(sessionControllerProvider, (previous, next) {
    refresh.value++;
  });

  return GoRouter(
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(sessionControllerProvider);
      return _redirectForSession(
        ref: ref,
        session: session,
        location: state.uri.path,
        state: state,
      );
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminDashboard,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.adminOnboard,
        builder: (context, state) => const AdminOnboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorDashboard,
        builder: (context, state) => const DoctorDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorPatients,
        builder: (context, state) => const DoctorPatientsScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorAppointments,
        builder: (context, state) => const DoctorAppointmentsScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorAppointmentDetail,
        builder: (context, state) => const DoctorAppointmentDetailScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorMedicalReport,
        builder: (context, state) => const DoctorMedicalReportScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorConfiguration,
        builder: (context, state) => const DoctorConfigurationScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorPlanner,
        builder: (context, state) => const DoctorPlannerScreen(),
      ),
      GoRoute(
        path: RoutePaths.doctorPreviewReport,
        builder: (context, state) => const DoctorPreviewReportScreen(),
      ),
      GoRoute(
        path: RoutePaths.staffDashboard,
        builder: (context, state) => const ReceptionistDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.staffAppointments,
        builder: (context, state) => const ReceptionistAppointmentsScreen(),
      ),
      GoRoute(
        path: RoutePaths.staffQueue,
        builder: (context, state) => const ReceptionistPatientQueueScreen(),
      ),
      GoRoute(
        path: RoutePaths.staffOnboardPatient,
        builder: (context, state) => const ReceptionistOnboardPatientScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientAppointments,
        builder: (context, state) => const PatientAppointmentsScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientBook,
        builder: (context, state) => const PatientBookAppointmentScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientBookAppointmentViaLink,
        builder: (context, state) => const PatientBookViaLinkScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientProfile,
        builder: (context, state) => const PatientProfileScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientSwitchUser,
        builder: (context, state) => const PatientSwitchUserScreen(),
      ),
      GoRoute(
        path: RoutePaths.chemistDashboard,
        builder: (context, state) => const ChemistDashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.chemistPrescriptions,
        builder: (context, state) => const ChemistPrescriptionsScreen(),
      ),
    ],
  );
}
