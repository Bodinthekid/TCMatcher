import 'package:flutter/material.dart';
import '../models/edit_store_profile_result.dart';
import '../theme/app_colors.dart';
import '../widgets/profile/profile_avatar_sheet.dart';
import '../widgets/store/profile/edit_store_app_bar.dart';
import '../widgets/store/profile/edit_store_fields_section.dart';
import '../widgets/store/profile/edit_store_media_header.dart';
import '../widgets/store/profile/store_banner_sheet.dart';

export '../models/edit_store_profile_result.dart';

class EditStoreProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialUsername;
  final String initialBio;
  final String initialAddress;
  final String initialOpeningHours;
  final String initialPhone;
  final String initialAvatarUrl;
  final String initialBannerUrl;

  const EditStoreProfileScreen({
    super.key,
    required this.initialName,
    required this.initialUsername,
    required this.initialBio,
    required this.initialAddress,
    required this.initialOpeningHours,
    required this.initialPhone,
    required this.initialAvatarUrl,
    required this.initialBannerUrl,
  });

  @override
  State<EditStoreProfileScreen> createState() => _EditStoreProfileScreenState();
}

class _EditStoreProfileScreenState extends State<EditStoreProfileScreen> {
  late final _nameController = TextEditingController(text: widget.initialName);
  late final _usernameController = TextEditingController(
    text: widget.initialUsername.replaceFirst('@', ''),
  );
  late final _bioController = TextEditingController(text: widget.initialBio);
  late final _addressController =
      TextEditingController(text: widget.initialAddress);
  late final _hoursController =
      TextEditingController(text: widget.initialOpeningHours);
  late final _phoneController = TextEditingController(text: widget.initialPhone);

  late String _avatarUrl = widget.initialAvatarUrl;
  late String _bannerUrl = widget.initialBannerUrl;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _hoursController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final username = _usernameController.text
        .trim()
        .replaceAll(' ', '')
        .replaceFirst('@', '');

    if (name.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Store name and handle cannot be empty.')),
      );
      return;
    }

    Navigator.pop(
      context,
      EditStoreProfileResult(
        name: name,
        username: username,
        bio: _bioController.text.trim(),
        address: _addressController.text.trim(),
        openingHours: _hoursController.text.trim(),
        phone: _phoneController.text.trim(),
        avatarUrl: _avatarUrl,
        bannerUrl: _bannerUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: EditStoreAppBar(
        onClose: () => Navigator.pop(context),
        onSave: _save,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EditStoreMediaHeader(
              bannerUrl: _bannerUrl,
              avatarUrl: _avatarUrl,
              onEditBanner: () => showStoreBannerSheet(
                context: context,
                currentUrl: _bannerUrl,
                onSelect: (url) => setState(() => _bannerUrl = url),
              ),
              onEditAvatar: () => showProfileAvatarSheet(
                context: context,
                currentUrl: _avatarUrl,
                onSelect: (url) => setState(() => _avatarUrl = url),
              ),
            ),
            EditStoreFieldsSection(
              nameController: _nameController,
              usernameController: _usernameController,
              bioController: _bioController,
              addressController: _addressController,
              hoursController: _hoursController,
              phoneController: _phoneController,
            ),
          ],
        ),
      ),
    );
  }
}