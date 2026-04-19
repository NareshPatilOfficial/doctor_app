import 'package:flutter/material.dart';

import '../../../../core/auth/user.dart';

/// Order matches web [USER_ROLES_DATA]: patient, doctor, staff, admin, chemist.
class RoleSelector extends StatelessWidget {
  const RoleSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final UserRole value;
  final ValueChanged<UserRole> onChanged;
  final bool enabled;

  static const _items = <({String label, UserRole role})>[
    (label: 'Patient', role: UserRole.patient),
    (label: 'Doctor', role: UserRole.doctor),
    (label: 'Staff / Receptionist', role: UserRole.staff),
    (label: 'Admin', role: UserRole.admin),
    (label: 'Chemist', role: UserRole.chemist),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<UserRole>(
      key: ValueKey<UserRole>(value),
      initialValue: value,
      decoration: const InputDecoration(
        labelText: 'Role',
        border: OutlineInputBorder(),
      ),
      onChanged: enabled
          ? (r) {
              if (r != null) {
                onChanged(r);
              }
            }
          : null,
      items: _items
          .map(
            (e) => DropdownMenuItem<UserRole>(
              value: e.role,
              child: Text(e.label),
            ),
          )
          .toList(),
    );
  }
}
