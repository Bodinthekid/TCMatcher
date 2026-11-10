import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreMapPreviewCard extends StatelessWidget {
  final String imageUrl;

  const StoreMapPreviewCard({
    super.key,
    this.imageUrl =
        'https://t4.ftcdn.net/jpg/03/38/37/73/360_F_338377354_1Y6oyGrvaae2kqY3YS07b6X4NDKZntne.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        imageUrl,
        height: 170,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 170,
          color: AppColors.surfaceLight,
          alignment: Alignment.center,
          child: const Icon(
            Icons.map_outlined,
            color: AppColors.textMuted,
            size: 36,
          ),
        ),
      ),
    );
  }
}