import 'package:flutter/material.dart';
import '../models/edit_profile_result.dart';
import '../theme/app_colors.dart';
import '../widgets/profile/edit_profile_form_body.dart';
import '../widgets/profile/profile_avatar_sheet.dart';

export '../models/edit_profile_result.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialUsername;
  final String initialBio;
  final String initialAvatarUrl;
  final Set<String> initialFavoriteGameIds;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialUsername,
    required this.initialBio,
    required this.initialAvatarUrl,
    required this.initialFavoriteGameIds,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late String _avatarUrl;
  late Set<String> _favoriteGameIds;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _usernameController = TextEditingController(
      text: widget.initialUsername.replaceFirst('@', ''),
    );
    _bioController = TextEditingController(text: widget.initialBio);
    _avatarUrl = widget.initialAvatarUrl;
    _favoriteGameIds = {...widget.initialFavoriteGameIds};
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _toggleFavoriteGame(String gameId) {
    setState(() {
      if (_favoriteGameIds.contains(gameId)) {
        _favoriteGameIds.remove(gameId);
      } else {
        _favoriteGameIds.add(gameId);
      }
    });
  }

  void _saveProfile() {
    final name = _nameController.text.trim();
    final username = _usernameController.text
        .trim()
        .replaceAll(' ', '')
        .replaceFirst('@', '');

    if (name.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and username cannot be empty.')),
      );
      return;
    }

    Navigator.pop(
      context,
      EditProfileResult(
        name: name,
        username: username,
        bio: _bioController.text.trim(),
        avatarUrl: _avatarUrl,
        favoriteGameIds: {..._favoriteGameIds},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Done',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: EditProfileFormBody(
        avatarUrl: _avatarUrl,
        nameController: _nameController,
        usernameController: _usernameController,
        bioController: _bioController,
        favoriteGameIds: _favoriteGameIds,
        onEditPicture: () => showProfileAvatarSheet(
          context: context,
          currentUrl: _avatarUrl,
          onSelect: (url) => setState(() => _avatarUrl = url),
        ),
        onToggleGame: _toggleFavoriteGame,
      ),
    );
  }
}