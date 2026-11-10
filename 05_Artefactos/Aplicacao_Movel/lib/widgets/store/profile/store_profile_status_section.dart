import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/achievement_badge.dart';

class StoreProfileStatusSection extends StatelessWidget {
  const StoreProfileStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.cardBorder, height: 26),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '● Open now  Today until 10:00 PM',
              style: TextStyle(
                color: AppColors.statusOnline,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Hours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AchievementBadge(
              icon: Icons.table_restaurant_outlined,
              label: '16 Playing Tables',
              color: Colors.white,
              bgColor: AppColors.surfaceLight,
            ),
            AchievementBadge(
              icon: Icons.local_cafe_outlined,
              label: 'Snacks Available',
              color: AppColors.accentCyan,
              bgColor: AppColors.accentCyanDark,
            ),
            AchievementBadge(
              icon: Icons.workspace_premium_outlined,
              label: 'Official Partner',
              color: AppColors.pokemonGold,
              bgColor: Color(0xFF332917),
            ),
          ],
        ),
      ],
    );
  }
}