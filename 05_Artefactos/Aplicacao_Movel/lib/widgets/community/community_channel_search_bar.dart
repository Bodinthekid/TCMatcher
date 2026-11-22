import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CommunityChannelSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String channelName;
  final ValueChanged<String> onChanged;

  const CommunityChannelSearchBar({
    super.key,
    required this.controller,
    required this.channelName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: AppColors.surface,
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: 'Search in #$channelName...',
          hintStyle: const TextStyle(color: AppColors.textMuted),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
            size: 18,
          ),
          filled: true,
          fillColor: AppColors.background,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}