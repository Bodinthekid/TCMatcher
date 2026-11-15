import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../screens/profile_screen.dart';
import 'user_avatar.dart';

class CompactPlayerCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String avatarUrl;
  final Color statusColor;
  final IconData gameIcon;
  final Color gameColor;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const CompactPlayerCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.avatarUrl,
    required this.statusColor,
    required this.gameIcon,
    required this.gameColor,
    required this.isHighlighted,
    this.onTap,
  });

  void _openProfile(BuildContext context) {
    if (onTap != null) {
      onTap!();
      return;
    }

    final handle = '@${name.toLowerCase().replaceAll(' ', '')}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          name: name,
          handleAndLocation: '$handle · $subtitle',
          avatarUrl: avatarUrl,
          statusLabel: statusColor == AppColors.statusAvailable
              ? 'Available to Play'
              : 'Online',
          statusColor: statusColor,
          showBackButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openProfile(context),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isHighlighted
                  ? AppColors.primaryPurple.withValues(alpha: 0.5)
                  : AppColors.cardBorder,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              UserAvatar(
                imageUrl: avatarUrl,
                size: 46,
                statusColor: statusColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: gameColor.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                  border: Border.all(color: gameColor.withValues(alpha: 0.6)),
                ),
                child: Icon(gameIcon, color: gameColor, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}