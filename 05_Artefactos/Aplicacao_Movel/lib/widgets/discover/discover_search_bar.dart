import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onFilterTap;

  const DiscoverSearchBar({
    super.key,
    this.controller,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Players, games, or stores',
                hintStyle: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: onFilterTap,
            child: const Icon(Icons.tune_rounded, color: AppColors.accentCyan, size: 20),
          ),
        ],
      ),
    );
  }
}