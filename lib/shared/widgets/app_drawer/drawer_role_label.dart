import 'package:doctorbridge_mobile_ui/core/auth/user.dart';

/// Short label for drawer header (UI only; API still uses [UserRole] strings).
String drawerRoleLabel(UserRole role) {
  return switch (role) {
    UserRole.admin => 'Admin',
    UserRole.doctor => 'Doctor',
    UserRole.staff => 'Receptionist',
    UserRole.patient => 'Patient',
    UserRole.chemist => 'Chemist',
  };
}
