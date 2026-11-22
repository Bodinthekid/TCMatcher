import 'package:flutter/material.dart';
import '../../../screens/login_screen.dart';
import '../../../services/auth_services.dart';
import '../../../theme/app_colors.dart';
import 'store_drawer_header.dart';

class StoreMenuDrawer extends StatelessWidget {
  final String storeName;
  final String avatarUrl;

  const StoreMenuDrawer({
    super.key,
    required this.storeName,
    required this.avatarUrl,
  });

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
          ? const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 20,
            )
          : null,
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = AuthService.currentUserEmail ??
        '@${storeName.toLowerCase().replaceAll(' ', '')}';

    return Drawer(
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreDrawerHeader(
              storeName: storeName,
              email: email,
              avatarUrl: avatarUrl,
            ),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 8),
            _buildItem(
              context: context,
              icon: Icons.settings_outlined,
              label: 'Store Settings',
            ),
            _buildItem(
              context: context,
              icon: Icons.notifications_none_rounded,
              label: 'Notifications',
            ),
            _buildItem(
              context: context,
              icon: Icons.verified_user_outlined,
              label: 'Store Verification',
            ),
            _buildItem(
              context: context,
              icon: Icons.help_outline_rounded,
              label: 'Help & Support',
            ),
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