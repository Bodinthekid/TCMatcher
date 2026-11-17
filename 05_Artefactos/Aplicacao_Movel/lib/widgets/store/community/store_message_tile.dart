import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../screens/profile_screen.dart';
import '../../../screens/store_profile_screen.dart';
import '../../shared/user_avatar.dart';

class StoreMessageTile extends StatelessWidget {
  final String user;
  final String role;
  final String time;
  final String avatarUrl;
  final String text;

  const StoreMessageTile({
    super.key,
    required this.user,
    required this.role,
    required this.time,
    required this.avatarUrl,
    required this.text,
  });

  void _openUserProfile(BuildContext context) {
    if (role == 'STORE') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StoreProfileScreen()),
      );
      return;
    }

    final handle = '@${user.toLowerCase().replaceAll(' ', '')}';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          name: user,
          handleAndLocation: '$handle · $role',
          avatarUrl: avatarUrl,
          statusLabel: 'Online',
          statusColor: AppColors.statusOnline,
          bio: text,
          showBackButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _openUserProfile(context),
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              imageUrl: avatarUrl,
              size: 38,
              statusColor: AppColors.statusOnline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$role · $time',
                        style: const TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}