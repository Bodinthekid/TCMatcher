import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import 'channel_empty_state.dart';

class ChannelLinksTab extends StatelessWidget {
  final String channelName;
  final List<CommunityMessage> messages;

  const ChannelLinksTab({
    super.key,
    required this.channelName,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final linkMessages = messages.where((m) => m.linkUrl != null).toList();

    if (linkMessages.isEmpty) {
      return ChannelEmptyState(
        icon: Icons.link_rounded,
        title: 'No links shared',
        subtitle: 'Links posted in #$channelName will be collected here.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: linkMessages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final m = linkMessages[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.link_rounded,
                  color: AppColors.accentCyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.linkUrl!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.accentCyan,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Shared by ${m.author} · ${m.timestamp}',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}