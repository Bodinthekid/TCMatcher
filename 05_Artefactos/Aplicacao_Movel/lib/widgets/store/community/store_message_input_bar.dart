import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreMessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final String currentChannel;
  final VoidCallback onSend;
  final VoidCallback? onAttachmentTap;

  const StoreMessageInputBar({
    super.key,
    required this.controller,
    required this.currentChannel,
    required this.onSend,
    this.onAttachmentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onAttachmentTap,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'Message #$currentChannel',
                  hintStyle: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13.5,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: AppColors.primaryPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}