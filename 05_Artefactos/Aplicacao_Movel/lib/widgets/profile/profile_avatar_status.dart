import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

class ProfileAvatarStatus extends StatelessWidget {
  final String avatarUrl;
  final Color statusColor;
  final bool isEditable;
  final VoidCallback onAvatarTap;

  const ProfileAvatarStatus({
    super.key,
    required this.avatarUrl,
    required this.statusColor,
    required this.isEditable,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEditable ? onAvatarTap : null,
      child: Stack(
        children: [
          UserAvatar(
            imageUrl: avatarUrl,
            size: 78,
            statusColor: statusColor,
          ),

          if (isEditable)
            const Positioned(
              right: 0,
              bottom: 0,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.primaryPurple,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfileHandleStatusRow extends StatelessWidget {
  final String handle;
  final String statusLabel;
  final Color statusColor;
  final Color statusBackground;
  final bool isEditable;
  final VoidCallback onStatusTap;

  const ProfileHandleStatusRow({
    super.key,
    required this.handle,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBackground,
    required this.isEditable,
    required this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            handle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.accentCyan,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 10),

        GestureDetector(
          onTap: isEditable ? onStatusTap : null,
          child: StatusBadge(
            label: statusLabel,
            dotColor: statusColor,
            backgroundColor: statusBackground,
          ),
        ),
      ],
    );
  }
}