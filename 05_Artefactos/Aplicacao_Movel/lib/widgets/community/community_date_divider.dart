import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CommunityDateDivider extends StatelessWidget {
  final String label;

  const CommunityDateDivider({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: AppColors.cardBorder, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: AppColors.cardBorder, height: 1),
          ),
        ],
      ),
    );
  }
}