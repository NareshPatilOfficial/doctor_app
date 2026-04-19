import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:flutter/material.dart';

/// Doctor branch navigation — edit this file only to change the doctor drawer.
const List<DrawerDestination> doctorDrawerDestinations = [
  DrawerDestination(
    label: 'Dashboard',
    goPath: RoutePaths.doctorDashboard,
    icon: Icons.dashboard_outlined,
  ),
  DrawerDestination(
    label: 'Patients',
    goPath: RoutePaths.doctorPatients,
    icon: Icons.people_outline,
  ),
  DrawerDestination(
    label: 'Appointments',
    goPath: RoutePaths.doctorAppointments,
    icon: Icons.calendar_month_outlined,
  ),
  DrawerDestination(
    label: 'Planner',
    goPath: RoutePaths.doctorPlanner,
    icon: Icons.view_week_outlined,
  ),
  DrawerDestination(
    label: 'Medical report',
    goPath: RoutePaths.doctorMedicalReport,
    icon: Icons.description_outlined,
  ),
  DrawerDestination(
    label: 'Configuration',
    goPath: RoutePaths.doctorConfiguration,
    icon: Icons.settings_outlined,
  ),
  DrawerDestination(
    label: 'Preview report',
    goPath: RoutePaths.doctorPreviewReport,
    icon: Icons.article_outlined,
  ),
];
