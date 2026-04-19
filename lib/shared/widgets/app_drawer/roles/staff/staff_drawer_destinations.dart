import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:flutter/material.dart';

/// Staff / receptionist branch — edit this file only to change the staff drawer.
const List<DrawerDestination> staffDrawerDestinations = [
  DrawerDestination(
    label: 'Dashboard',
    goPath: RoutePaths.staffDashboard,
    icon: Icons.dashboard_outlined,
  ),
  DrawerDestination(
    label: 'Appointments',
    goPath: RoutePaths.staffAppointments,
    icon: Icons.calendar_month_outlined,
  ),
  DrawerDestination(
    label: 'Patient queue',
    goPath: RoutePaths.staffQueue,
    icon: Icons.groups_outlined,
  ),
  DrawerDestination(
    label: 'Onboard patient',
    goPath: RoutePaths.staffOnboardPatient,
    icon: Icons.person_add_outlined,
  ),
];
