import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:flutter/material.dart';

/// Chemist branch — edit this file only to change the chemist drawer.
const List<DrawerDestination> chemistDrawerDestinations = [
  DrawerDestination(
    label: 'Dashboard',
    goPath: RoutePaths.chemistDashboard,
    icon: Icons.dashboard_outlined,
  ),
  DrawerDestination(
    label: 'Prescriptions',
    goPath: RoutePaths.chemistPrescriptions,
    icon: Icons.medication_outlined,
  ),
];
