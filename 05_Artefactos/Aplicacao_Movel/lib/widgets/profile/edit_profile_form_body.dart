import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';
import 'edit_favorite_games_section.dart';
import 'edit_profile_field.dart';

class EditProfileFormBody extends StatelessWidget {
  final String avatarUrl;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final Set<String> favoriteGameIds;
  final VoidCallback onEditPicture;
  final ValueChanged<String> onToggleGame;

  const EditProfileFormBody({
    super.key,
    required this.avatarUrl,
    required this.nameController,
    required this.usernameController,
    required this.bioController,
    required this.favoriteGameIds,
    required this.onEditPicture,
    required this.onToggleGame,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          UserAvatar(
            imageUrl: avatarUrl,
            size: 96,
            statusColor: AppColors.statusOnline,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onEditPicture,
            child: const Text(
              'Edit picture',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 22),
          EditProfileField(label: 'Name', controller: nameController),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(
            label: 'Username',
            controller: usernameController,
            prefixText: '@',
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(
            label: 'Bio',
            controller: bioController,
            maxLines: 4,
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          const SizedBox(height: 24),
          EditFavoriteGamesSection(
            selectedGameIds: favoriteGameIds,
            onToggle: onToggleGame,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}