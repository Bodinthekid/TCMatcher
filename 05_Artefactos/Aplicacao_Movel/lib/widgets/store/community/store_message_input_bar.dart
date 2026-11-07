import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreMessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final String currentChannel;
  final VoidCallback onSend;

  const StoreMessageInputBar({
    super.key,
    required this.controller,
    required this.currentChannel,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Message #$currentChannel',
                hintStyle: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onSend,
            icon: const Icon(
              Icons.send_rounded,
              color: AppColors.primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}