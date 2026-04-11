// =============================================================================
// role_route_extension.dart — Map UserRole → home route and path prefix
// =============================================================================
// Used by go_router redirects to send users to the correct home and to reject
// cross-role URLs. See docs/go-router.md.
// =============================================================================

import '../auth/user.dart';
import 'route_paths.dart';

extension UserRoleRouting on UserRole {
  String get homePath => switch (this) {
        UserRole.admin => RoutePaths.adminDashboard,
        UserRole.doctor => RoutePaths.doctorDashboard,
        UserRole.staff => RoutePaths.staffDashboard,
        UserRole.patient => RoutePaths.patientAppointments,
        UserRole.chemist => RoutePaths.chemistDashboard,
      };

  String get branchPrefix => switch (this) {
        UserRole.admin => RoutePaths.admin,
        UserRole.doctor => RoutePaths.doctor,
        UserRole.staff => RoutePaths.staff,
        UserRole.patient => RoutePaths.patient,
        UserRole.chemist => RoutePaths.chemist,
      };
}

bool roleAllowsPath(UserRole role, String location) {
  final prefix = role.branchPrefix;
  return location == prefix || location.startsWith('$prefix/');
}
