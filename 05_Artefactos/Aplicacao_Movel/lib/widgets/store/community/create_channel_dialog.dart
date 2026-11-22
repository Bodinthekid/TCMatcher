import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';

Future<CommunityChannel?> showCreateChannelDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final topicController = TextEditingController();

  final created = await showDialog<CommunityChannel>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.cardBorder),
      ),
      title: const Text(
        'Create Text Channel',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'channel-name',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              prefixIcon: const Icon(
                Icons.tag_rounded,
                color: AppColors.accentCyan,
                size: 18,
              ),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: topicController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Topic (optional)',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final slug = nameController.text
                .trim()
                .toLowerCase()
                .replaceAll(RegExp(r'\s+'), '-');
            if (slug.isEmpty) return;

            Navigator.pop(
              ctx,
              CommunityChannel(
                id: '${slug}_${DateTime.now().millisecondsSinceEpoch}',
                name: slug,
                topic: topicController.text.trim().isEmpty
                    ? 'Store community channel'
                    : topicController.text.trim(),
                category: 'TEXT CHANNELS',
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Create'),
        ),
      ],
    ),
  );

  nameController.dispose();
  topicController.dispose();
  return created;
}