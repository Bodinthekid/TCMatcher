import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import 'channel_empty_state.dart';

class ChannelPinnedTab extends StatelessWidget {
  final List<CommunityMessage> messages;

  const ChannelPinnedTab({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final pinned = messages.where((m) => m.isPinned).toList();

    if (pinned.isEmpty) {
      return const ChannelEmptyState(
        icon: Icons.push_pin_outlined,
        title: 'No pinned messages',
        subtitle:
            'Important announcements pinned in this channel will appear here.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: pinned.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final m = pinned[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    m.author,
                    style: const TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    m.timestamp,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                m.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}