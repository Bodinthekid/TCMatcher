import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../profile/edit_profile_field.dart';

class EditStoreFieldsSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final TextEditingController addressController;
  final TextEditingController hoursController;
  final TextEditingController phoneController;

  const EditStoreFieldsSection({
    super.key,
    required this.nameController,
    required this.usernameController,
    required this.bioController,
    required this.addressController,
    required this.hoursController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          EditProfileField(label: 'Store', controller: nameController),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(
            label: 'Handle',
            controller: usernameController,
            prefixText: '@',
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(
            label: 'Bio',
            controller: bioController,
            maxLines: 3,
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(
            label: 'Address',
            controller: addressController,
            maxLines: 2,
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(label: 'Hours', controller: hoursController),
          const Divider(color: AppColors.cardBorder, height: 1),
          EditProfileField(label: 'Phone', controller: phoneController),
          const Divider(color: AppColors.cardBorder, height: 1),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}