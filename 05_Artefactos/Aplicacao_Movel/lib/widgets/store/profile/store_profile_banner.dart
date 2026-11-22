import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import 'store_banner_action_button.dart';
import 'store_banner_avatar.dart';

class StoreProfileBanner extends StatelessWidget {
  final String bannerUrl;
  final String avatarUrl;
  final bool isEditable;
  final bool showBackButton;
  final VoidCallback? onMenuTap;
  final VoidCallback onAvatarTap;
  final VoidCallback onActionTap;

  const StoreProfileBanner({
    super.key,
    required this.bannerUrl,
    required this.avatarUrl,
    required this.isEditable,
    required this.showBackButton,
    required this.onAvatarTap,
    required this.onActionTap,
    this.onMenuTap,
  });

  static const double _bannerHeight = 140;
  static const double _avatarSize = 86;
  static const double _avatarRing = 5;

  Widget _buildOverlayIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.65),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final overlap = (_avatarSize + (_avatarRing * 2)) / 2;

    return SizedBox(
      height: _bannerHeight + overlap,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _bannerHeight,
            child: Image.network(
              bannerUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryPurpleDark, AppColors.surface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _bannerHeight,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.35),
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.45),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          if (showBackButton)
            Positioned(
              top: 12,
              left: 16,
              child: _buildOverlayIcon(
                Icons.arrow_back_rounded,
                () => Navigator.pop(context),
              ),
            ),
          if (!showBackButton && onMenuTap != null)
            Positioned(
              top: 12,
              right: 16,
              child: _buildOverlayIcon(Icons.menu_rounded, onMenuTap!),
            ),
          Positioned(
            top: _bannerHeight - overlap,
            left: 20,
            child: StoreBannerAvatar(
              avatarUrl: avatarUrl,
              size: _avatarSize,
              ring: _avatarRing,
              isEditable: isEditable,
              onTap: onAvatarTap,
            ),
          ),
          Positioned(
            top: _bannerHeight + 12,
            right: 20,
            child: StoreBannerActionButton(
              isEditable: isEditable,
              onPressed: onActionTap,
            ),
          ),
        ],
      ),
    );
  }
}