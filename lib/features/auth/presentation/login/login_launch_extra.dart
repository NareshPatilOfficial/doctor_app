/// Pass via `GoRouter` [GoRouterState.extra] to pre-select patient + return path.
class LoginLaunchExtra {
  const LoginLaunchExtra({this.returnPath});

  /// Post-login navigation (e.g. [RoutePaths.patientBookAppointmentViaLink]).
  final String? returnPath;
}
