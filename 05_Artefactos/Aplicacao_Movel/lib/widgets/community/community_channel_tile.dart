import 'package:flutter/material.dart';
import '../../models/store_community_models.dart';
import '../../theme/app_colors.dart';

class CommunityChannelTile extends StatelessWidget {
  final CommunityChannel channel;
  final bool isSelected;
  final VoidCallback onTap;

  const CommunityChannelTile({
    super.key,
    required this.channel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = channel.unreadCount > 0 && !isSelected;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.surfaceLight : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  channel.isAnnouncement
                      ? Icons.campaign_rounded
                      : Icons.tag_rounded,
                  size: 19,
                  color: isSelected
                      ? AppColors.accentCyan
                      : hasUnread
                          ? Colors.white
                          : AppColors.textMuted,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    channel.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected || hasUnread
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontSize: 14.5,
                      fontWeight: isSelected || hasUnread
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${channel.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}