import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../screens/profile_screen.dart';
import '../shared_widgets.dart';

class StrongMatchCard extends StatelessWidget {
  const StrongMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfileScreen(
              name: 'Eli Rivera',
              handleAndLocation: '@elirivera · 1.4 mi',
              avatarUrl: 'https://i.pravatar.cc/150?img=12',
              statusLabel: 'Available to Play',
              statusColor: AppColors.statusAvailable,
              bio: '92% match fit · 4.9 sportsmanship rating.',
              showBackButton: true,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'STRONG MATCH',
                  style: TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
                Text(
                  '92% fit',
                  style: TextStyle(
                    color: AppColors.statusOnline,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                UserAvatar(
                  imageUrl: 'https://i.pravatar.cc/150?img=12',
                  size: 44,
                  statusColor: AppColors.statusAvailable,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eli Rivera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '1.4 mi · 4.9 sportsmanship',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: AppColors.pokemonGold,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.9',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}