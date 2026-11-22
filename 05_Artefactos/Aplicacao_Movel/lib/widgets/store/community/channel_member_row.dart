import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import '../../shared_widgets.dart';

class ChannelMemberRow extends StatelessWidget {
  final CommunityMember member;

  const ChannelMemberRow({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    final isSpecial = member.role == 'STORE' || member.role == 'MOD';
    final badgeColor = member.role == 'STORE'
        ? AppColors.primaryPurple
        : AppColors.accentCyan;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Opacity(
            opacity: member.isOnline ? 1.0 : 0.55,
            child: UserAvatar(
              imageUrl: member.avatarUrl,
              size: 38,
              statusColor: member.statusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              member.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    member.isOnline ? Colors.white : AppColors.textSecondary,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isSpecial)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                member.role,
                style: TextStyle(
                  color: badgeColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}