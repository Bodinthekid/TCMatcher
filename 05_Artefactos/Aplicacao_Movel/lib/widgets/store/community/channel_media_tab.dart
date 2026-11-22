import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import 'channel_empty_state.dart';

class ChannelMediaTab extends StatelessWidget {
  final String channelName;
  final List<CommunityMessage> messages;

  const ChannelMediaTab({
    super.key,
    required this.channelName,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final mediaUrls =
        messages.map((m) => m.imageUrl).whereType<String>().toList();

    if (mediaUrls.isEmpty) {
      return ChannelEmptyState(
        icon: Icons.photo_library_outlined,
        title: 'No media yet',
        subtitle: 'Images shared in #$channelName will appear here.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mediaUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            mediaUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.surfaceLight,
              child: const Icon(
                Icons.image_outlined,
                color: AppColors.textMuted,
              ),
            ),
          ),
        );
      },
    );
  }
}