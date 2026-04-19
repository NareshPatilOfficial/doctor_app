import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/roles/admin/admin_drawer_destinations.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/roles/chemist/chemist_drawer_destinations.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/roles/doctor/doctor_drawer_destinations.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/roles/patient/patient_drawer_destinations.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/roles/staff/staff_drawer_destinations.dart';

/// Single place to map [UserRole] → drawer items. Add a role file under
/// `roles/<role>/` and register it here.
List<DrawerDestination> drawerDestinationsForRole(UserRole role) {
  return switch (role) {
    UserRole.admin => adminDrawerDestinations,
    UserRole.doctor => doctorDrawerDestinations,
    UserRole.staff => staffDrawerDestinations,
    UserRole.patient => patientDrawerDestinations,
    UserRole.chemist => chemistDrawerDestinations,
  };
}
