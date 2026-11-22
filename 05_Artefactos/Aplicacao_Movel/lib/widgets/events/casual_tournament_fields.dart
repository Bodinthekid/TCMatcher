import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'tournament_form_helpers.dart';

class CasualTournamentFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final int selectedGameId;
  final double maxSlots;
  final bool isPrivate;
  final DateTime startTime;
  final ValueChanged<int> onGameChanged;
  final ValueChanged<double> onMaxSlotsChanged;
  final ValueChanged<bool> onPrivateChanged;
  final VoidCallback onSelectStartTime;

  const CasualTournamentFields({
    super.key,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.selectedGameId,
    required this.maxSlots,
    required this.isPrivate,
    required this.startTime,
    required this.onGameChanged,
    required this.onMaxSlotsChanged,
    required this.onPrivateChanged,
    required this.onSelectStartTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: titleController,
          style: const TextStyle(color: Colors.white),
          decoration:
              tournamentInputDecoration('Ex: Casual Park Session / Home Game'),
          validator: (v) => v == null || v.isEmpty ? 'Required field' : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(
          initialValue: selectedGameId,
          dropdownColor: const Color(0xFF1E1E1E),
          style: const TextStyle(color: Colors.white),
          decoration: tournamentInputDecoration('Select TCG Game'),
          items: const [
            DropdownMenuItem(value: 1, child: Text('Magic: The Gathering')),
            DropdownMenuItem(value: 2, child: Text('Pokémon TCG')),
            DropdownMenuItem(value: 3, child: Text('One Piece TCG')),
            DropdownMenuItem(value: 4, child: Text('Yu-Gi-Oh!')),
          ],
          onChanged: (v) => onGameChanged(v!),
        ),
        const SizedBox(height: 16),
        Text(
          'Max Player Slots: ${maxSlots.toInt()}',
          style: const TextStyle(color: Colors.white70),
        ),
        Slider(
          value: maxSlots,
          min: 4,
          max: 32,
          divisions: 7,
          activeColor: AppColors.primaryPurple,
          onChanged: onMaxSlotsChanged,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: locationController,
          style: const TextStyle(color: Colors.white),
          decoration:
              tournamentInputDecoration('Ex: Main Street, nº 123 or City Park'),
          validator: (v) => v == null || v.isEmpty ? 'Required field' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: descriptionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: tournamentInputDecoration(
            'Ex: Bring standard deck, starts at 3 PM... (Optional)',
          ),
        ),
        const SizedBox(height: 16),
        TournamentDateTimeCard(
          label: 'Tournament Start Date & Time',
          dateTime: startTime,
          onTap: onSelectStartTime,
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text(
            'Private Tournament',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: const Text(
            'Hidden from public map',
            style: TextStyle(color: AppColors.textMuted),
          ),
          value: isPrivate,
          activeThumbColor: AppColors.primaryPurple,
          onChanged: onPrivateChanged,
        ),
      ],
    );
  }
}