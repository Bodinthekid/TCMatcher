import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreBannerActionButton extends StatelessWidget {
  final bool isEditable;
  final VoidCallback onPressed;

  const StoreBannerActionButton({
    super.key,
    required this.isEditable,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = !isEditable;

    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary ? AppColors.primaryPurple : AppColors.surfaceLight,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color:
                  isPrimary ? AppColors.primaryPurple : AppColors.cardBorder,
            ),
          ),
        ),
        child: Text(
          isEditable ? 'Edit store' : 'Message',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}