import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreBannerAvatar extends StatelessWidget {
  final String avatarUrl;
  final double size;
  final double ring;
  final bool isEditable;
  final VoidCallback onTap;

  const StoreBannerAvatar({
    super.key,
    required this.avatarUrl,
    required this.size,
    required this.ring,
    required this.isEditable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalSize = size + (ring * 2);

    return GestureDetector(
      onTap: isEditable ? onTap : null,
      child: Container(
        width: totalSize,
        height: totalSize,
        padding: EdgeInsets.all(ring),
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.network(
            avatarUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.surfaceLight,
              child: const Icon(
                Icons.storefront_rounded,
                color: AppColors.accentCyan,
                size: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}