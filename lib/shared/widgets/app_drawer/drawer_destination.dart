import 'package:flutter/material.dart';

/// One row in [AppRoleDrawer]. Paths must match [RoutePaths] / go_router.
class DrawerDestination {
  const DrawerDestination({
    required this.label,
    required this.goPath,
    this.icon = Icons.circle_outlined,
  });

  final String label;
  final String goPath;
  final IconData icon;
}
