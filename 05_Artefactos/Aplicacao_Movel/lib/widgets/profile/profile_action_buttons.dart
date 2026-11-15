import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ProfileActionButtons extends StatelessWidget {
  final bool isEditable;

  final VoidCallback onEditProfile;
  final VoidCallback onChangeStatus;
  final VoidCallback onConnect;
  final VoidCallback onMessage;

  const ProfileActionButtons({
    super.key,
    required this.isEditable,
    required this.onEditProfile,
    required this.onChangeStatus,
    required this.onConnect,
    required this.onMessage,
  });

  Widget _buildButton({
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Expanded(
      child: SizedBox(
        height: 36,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary
                ? AppColors.primaryPurple
                : AppColors.surfaceLight,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: isPrimary
                    ? AppColors.primaryPurple
                    : AppColors.cardBorder,
              ),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isEditable) {
      return Row(
        children: [
          _buildButton(
            label: 'Edit profile',
            onTap: onEditProfile,
          ),
          const SizedBox(width: 8),
          _buildButton(
            label: 'Change status',
            onTap: onChangeStatus,
          ),
        ],
      );
    }

    return Row(
      children: [
        _buildButton(
          label: 'Connect',
          onTap: onConnect,
          isPrimary: true,
        ),
        const SizedBox(width: 8),
        _buildButton(
          label: 'Message',
          onTap: onMessage,
        ),
      ],
    );
  }
}