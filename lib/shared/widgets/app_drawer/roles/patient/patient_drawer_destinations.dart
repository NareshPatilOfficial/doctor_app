import 'package:doctorbridge_mobile_ui/core/routing/route_paths.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:flutter/material.dart';

/// Patient branch — edit this file only to change the patient drawer.
const List<DrawerDestination> patientDrawerDestinations = [
  DrawerDestination(
    label: 'Appointments',
    goPath: RoutePaths.patientAppointments,
    icon: Icons.calendar_month_outlined,
  ),
  DrawerDestination(
    label: 'Book appointment',
    goPath: RoutePaths.patientBook,
    icon: Icons.event_available_outlined,
  ),
  DrawerDestination(
    label: 'Profile',
    goPath: RoutePaths.patientProfile,
    icon: Icons.person_outline,
  ),
  DrawerDestination(
    label: 'Switch user',
    goPath: RoutePaths.patientSwitchUser,
    icon: Icons.switch_account_outlined,
  ),
  DrawerDestination(
    label: 'Book via link',
    goPath: RoutePaths.patientBookAppointmentViaLink,
    icon: Icons.link_outlined,
  ),
];
