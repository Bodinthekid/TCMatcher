import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MatchPreferenceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MatchPreferenceRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.accentCyanDark,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.accentCyan, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
            size: 18,
          ),
        ],
      ),
    );
  }
}