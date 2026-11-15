import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_services.dart';
import '../../screens/login_screen.dart';
import '../shared_widgets.dart';
import 'profile_header_card.dart';

class ProfileMenuDrawer extends StatelessWidget {
  const ProfileMenuDrawer({super.key});

  void _handleLogout(BuildContext context) {
    AuthService.currentUserId = null;
    AuthService.currentUserName = null;
    AuthService.currentUserEmail = null;
    AuthService.currentAccountType = null;

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: color == Colors.white
          ? const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20)
          : null,
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = AuthService.currentUserName ?? 'Player';
    final email = AuthService.currentUserEmail ?? '@${name.toLowerCase().replaceAll(' ', '')}';

    return Drawer(
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  UserAvatar(
                    imageUrl: ProfileHeaderCard.savedAvatar,
                    size: 48,
                    statusColor: ProfileHeaderCard.savedStatus.color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 8),
            _buildItem(context: context, icon: Icons.settings_outlined, label: 'Settings'),
            _buildItem(context: context, icon: Icons.notifications_none_rounded, label: 'Notifications'),
            _buildItem(context: context, icon: Icons.lock_outline_rounded, label: 'Privacy & Security'),
            _buildItem(context: context, icon: Icons.help_outline_rounded, label: 'Help & Support'),
            const Spacer(),
            const Divider(color: AppColors.cardBorder, height: 1),
            _buildItem(
              context: context,
              icon: Icons.logout_rounded,
              label: 'Log Out',
              color: AppColors.errorRed,
              onTap: () => _handleLogout(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}