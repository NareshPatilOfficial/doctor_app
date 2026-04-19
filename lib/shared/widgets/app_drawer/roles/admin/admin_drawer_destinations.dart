import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:flutter/material.dart';

/// Admin branch navigation — edit this file only to change the admin drawer.
const List<DrawerDestination> adminDrawerDestinations = [
  DrawerDestination(
    label: 'Dashboard',
    goPath: RoutePaths.adminDashboard,
    icon: Icons.dashboard_outlined,
  ),
  DrawerDestination(
    label: 'Onboard',
    goPath: RoutePaths.adminOnboard,
    icon: Icons.person_add_outlined,
  ),
];
