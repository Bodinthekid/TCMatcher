import 'package:flutter/material.dart';
import '../../../models/store_profile_data.dart';
import '../../../theme/app_colors.dart';

class StoreAboutTab extends StatelessWidget {
  final StoreProfileData storeData;

  const StoreAboutTab({
    super.key,
    required this.storeData,
  });

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentCyan, size: 19),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Store details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: storeData.address,
              ),
              const Divider(color: AppColors.cardBorder, height: 1),
              _buildInfoRow(
                icon: Icons.access_time_rounded,
                label: 'Opening hours',
                value: storeData.openingHours,
              ),
              const Divider(color: AppColors.cardBorder, height: 1),
              _buildInfoRow(
                icon: Icons.phone_outlined,
                label: 'Contact',
                value: storeData.phone,
              ),
              const Divider(color: AppColors.cardBorder, height: 1),
              _buildInfoRow(
                icon: Icons.table_restaurant_outlined,
                label: 'Play space',
                value: '${storeData.tablesCount} tables available for casual & tournament play',
              ),
            ],
          ),
        ),
      ],
    );
  }
}