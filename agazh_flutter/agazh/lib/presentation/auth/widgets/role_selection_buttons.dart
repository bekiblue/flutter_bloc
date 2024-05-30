import 'package:agazh/domain/auth/user_model.dart';
import 'package:flutter/material.dart';

class RoleSelectionButton extends StatelessWidget {
  final String label;
  final Role value;
  final Role selectedRole;
  final ValueChanged<Role> onChanged;

  const RoleSelectionButton({
    super.key,
    required this.label,
    required this.value,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: selectedRole == value ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedRole == value ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
