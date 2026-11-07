import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'user_avatar.dart';
import 'status_badge.dart';

class GameBadgeData {
  final IconData icon;
  final Color color;
  const GameBadgeData(this.icon, this.color);
}

class DetailedPlayerCard extends StatelessWidget {
  final String name;
  final String handleAndDistance;
  final String avatarUrl;
  final String statusLabel;
  final Color statusColor;
  final String bio;
  final List<GameBadgeData> gameBadges;
  final bool isHighlighted;

  const DetailedPlayerCard({
    super.key,
    required this.name,
    required this.handleAndDistance,
    required this.avatarUrl,
    required this.statusLabel,
    required this.statusColor,
    required this.bio,
    required this.gameBadges,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primaryPurple.withValues(alpha: 0.55)
              : AppColors.cardBorder,
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(
                imageUrl: avatarUrl,
                size: 48,
                statusColor: statusColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      handleAndDistance,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: statusLabel,
                dotColor: statusColor,
                backgroundColor: AppColors.surfaceLight,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ...gameBadges.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: b.color.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                      border: Border.all(color: b.color.withValues(alpha: 0.6)),
                    ),
                    child: Icon(b.icon, color: b.color, size: 16),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  bio,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Connect',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.cardBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}