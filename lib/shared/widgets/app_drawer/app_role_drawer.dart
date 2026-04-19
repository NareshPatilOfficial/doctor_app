import 'package:doctorbridge_mobile_ui/core/auth/session_controller.dart';
import 'package:doctorbridge_mobile_ui/core/auth/user.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destination.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_destinations_for_role.dart';
import 'package:doctorbridge_mobile_ui/shared/widgets/app_drawer/drawer_role_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

bool _pathMatchesSelection(String currentPath, String destPath) {
  if (currentPath == destPath) {
    return true;
  }
  if (destPath.length <= 1) {
    return false;
  }
  return currentPath.startsWith('$destPath/');
}

/// Role-specific items from [drawerDestinationsForRole] plus **Sign out** (all roles).
class AppRoleDrawer extends ConsumerWidget {
  const AppRoleDrawer({
    required this.user,
    super.key,
  });

  final User user;

  Future<void> _confirmAndLogout(BuildContext context, WidgetRef ref) async {
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (go != true || !context.mounted) {
      return;
    }
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    await ref.read(sessionControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = GoRouterState.of(context).uri.path;
    final items = drawerDestinationsForRole(user.role);
    final roleTitle = drawerRoleLabel(user.role);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    user.displayName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(roleTitle),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final DrawerDestination d in items)
                    ListTile(
                      leading: Icon(d.icon),
                      title: Text(d.label),
                      selected: _pathMatchesSelection(currentPath, d.goPath),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(d.goPath);
                      },
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign out'),
              onTap: () => _confirmAndLogout(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
