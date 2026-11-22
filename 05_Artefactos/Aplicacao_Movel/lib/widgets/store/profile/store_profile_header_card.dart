import 'package:flutter/material.dart';
import '../../../models/store_profile_data.dart';
import '../../../screens/edit_store_profile_screen.dart';
import '../../../theme/app_colors.dart';
import 'store_profile_banner.dart';

class StoreProfileHeaderCard extends StatelessWidget {
  final StoreProfileData storeData;
  final bool isEditable;
  final bool showBackButton;
  final VoidCallback? onMenuTap;
  final ValueChanged<EditStoreProfileResult> onStoreEdited;
  final VoidCallback? onMessageTap;

  const StoreProfileHeaderCard({
    super.key,
    required this.storeData,
    required this.isEditable,
    required this.showBackButton,
    required this.onStoreEdited,
    this.onMenuTap,
    this.onMessageTap,
  });

  Future<void> _openEditStore(BuildContext context) async {
    final result = await Navigator.push<EditStoreProfileResult>(
      context,
      MaterialPageRoute(
        builder: (_) => EditStoreProfileScreen(
          initialName: storeData.name,
          initialUsername: storeData.username,
          initialBio: storeData.bio,
          initialAddress: storeData.address,
          initialOpeningHours: storeData.openingHours,
          initialPhone: storeData.phone,
          initialAvatarUrl: storeData.avatarUrl,
          initialBannerUrl: storeData.bannerUrl,
        ),
      ),
    );

    if (result != null) onStoreEdited(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoreProfileBanner(
          bannerUrl: storeData.bannerUrl,
          avatarUrl: storeData.avatarUrl,
          isEditable: isEditable,
          showBackButton: showBackButton,
          onMenuTap: onMenuTap,
          onAvatarTap: () => _openEditStore(context),
          onActionTap: isEditable
              ? () => _openEditStore(context)
              : (onMessageTap ?? () {}),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      storeData.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.verified_rounded,
                    color: AppColors.accentCyan,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                '@${storeData.username}',
                style: const TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (storeData.bio.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  storeData.bio,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}