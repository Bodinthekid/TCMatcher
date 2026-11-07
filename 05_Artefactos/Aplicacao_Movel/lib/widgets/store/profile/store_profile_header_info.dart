import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/achievement_badge.dart';
import '../../shared/header_icon_button.dart';

class StoreProfileHeaderInfo extends StatelessWidget {
  const StoreProfileHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Mana Vault Games',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 8),
            AchievementBadge(
              icon: Icons.verified_outlined,
              label: 'Verified Store',
              color: AppColors.pokemonGold,
              bgColor: Color(0xFF332917),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.accentCyan,
              size: 15,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                '2140 SE Hawthorne Blvd · Portland, OR',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              '1.8 mi',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          '@manavaultgames  ·  manavault.gg  ·  Call',
          style: TextStyle(color: AppColors.accentCyan, fontSize: 12),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.near_me_outlined, size: 16),
                label: const Text(
                  'Get Directions',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            HeaderIconButton(icon: Icons.camera_alt_outlined, onTap: () {}),
            const SizedBox(width: 8),
            HeaderIconButton(icon: Icons.language_rounded, onTap: () {}),
            const SizedBox(width: 8),
            HeaderIconButton(icon: Icons.phone_in_talk_outlined, onTap: () {}),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Your neighborhood home for weekly leagues, friendly competition, and every card game you love.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}