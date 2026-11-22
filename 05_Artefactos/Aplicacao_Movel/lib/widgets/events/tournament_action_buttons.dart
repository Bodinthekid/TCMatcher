import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TournamentActionButtons extends StatelessWidget {
  final bool isCreator;
  final bool isLoading;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onJoinTap;

  const TournamentActionButtons({
    super.key,
    required this.isCreator,
    required this.isLoading,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!isCreator) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: isLoading ? null : onJoinTap,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Join Tournament',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.edit, color: Colors.white, size: 18),
            label: const Text(
              'Manage & Edit Tournament',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: onEditTap,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text(
              'Delete Tournament',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onDeleteTap,
          ),
        ),
      ],
    );
  }
}