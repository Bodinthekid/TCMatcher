import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'tournament_form_helpers.dart';

class TournamentEditForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const TournamentEditForm({
    super.key,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.isLoading,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit Tournament',
          style: TextStyle(
            color: AppColors.accentCyan,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: titleController,
          style: const TextStyle(color: Colors.white),
          decoration: tournamentInputDecoration('Tournament Title'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: locationController,
          style: const TextStyle(color: Colors.white),
          decoration: tournamentInputDecoration('Location / Address'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: descriptionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: tournamentInputDecoration('Description / Rules'),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                ),
                onPressed: onCancel,
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                ),
                onPressed: isLoading ? null : onSave,
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}