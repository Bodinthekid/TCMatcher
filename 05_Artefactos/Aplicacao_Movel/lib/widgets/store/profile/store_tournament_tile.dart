import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../common/store_avatar_badge.dart';
import '../common/store_card.dart';

class StoreTournamentTile extends StatelessWidget {
  final String code;
  final Color color;
  final String title;
  final String date;
  final String fee;

  const StoreTournamentTile({
    super.key,
    required this.code,
    required this.color,
    required this.title,
    required this.date,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return StoreCard(
      child: Row(
        children: [
          StoreAvatarBadge(text: code, size: 48, color: color, isCircle: true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Entry Fee $fee',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.auto_awesome, size: 13),
            label: const Text(
              "I'm Interested",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 34),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}