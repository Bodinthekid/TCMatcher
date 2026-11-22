import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';

class StoreChatHeader extends StatelessWidget {
  final CommunityChannel channel;
  final int memberCount;
  final bool isSearching;
  final VoidCallback onBackToChannels;
  final VoidCallback onChannelDetailsTap;
  final VoidCallback onToggleSearch;

  const StoreChatHeader({
    super.key,
    required this.channel,
    required this.memberCount,
    required this.isSearching,
    required this.onBackToChannels,
    required this.onChannelDetailsTap,
    required this.onToggleSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackToChannels,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
            tooltip: 'Channels',
          ),
          Expanded(
            child: GestureDetector(
              onTap: onChannelDetailsTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        channel.isAnnouncement
                            ? Icons.campaign_rounded
                            : Icons.tag_rounded,
                        color: AppColors.accentCyan,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          channel.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textMuted,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.statusOnline,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$memberCount Members',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onToggleSearch,
            icon: Icon(
              isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: isSearching ? AppColors.accentCyan : Colors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}