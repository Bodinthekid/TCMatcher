import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'tournament_action_buttons.dart';

class TournamentDetailsBody extends StatelessWidget {
  final dynamic tournament;
  final bool isCreator;
  final bool isLoading;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onJoinTap;

  const TournamentDetailsBody({
    super.key,
    required this.tournament,
    required this.isCreator,
    required this.isLoading,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.onJoinTap,
  });

  String _formatDate() {
    if (tournament['start_time'] == null) return 'Time not set';
    try {
      final dt = DateTime.parse(tournament['start_time'].toString()).toLocal();
      return '${dt.day.toString().padLeft(2, '0')}/'
          '${dt.month.toString().padLeft(2, '0')}/${dt.year} • '
          '${dt.hour.toString().padLeft(2, '0')}:'
          '${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return 'Time not set';
    }
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentCyan, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final organizerName =
        (tournament['organizer_name'] ?? 'Unknown Creator').toString();
    final description = (tournament['description'] ?? '').toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (tournament['title'] ?? 'Tournament').toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Organized by $organizerName',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 20),
        _buildInfoRow(
          Icons.location_on_outlined,
          (tournament['location_name'] ?? 'Location not specified').toString(),
        ),
        const SizedBox(height: 10),
        _buildInfoRow(
          Icons.people_outline,
          '${tournament['max_slots'] ?? 8} Maximum Player Slots',
        ),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.access_time, _formatDate()),
        const SizedBox(height: 20),
        const Divider(color: Colors.white10),
        const SizedBox(height: 10),
        const Text(
          'Description & Rules',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description.isEmpty
              ? 'No description provided for this event.'
              : description,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 30),
        TournamentActionButtons(
          isCreator: isCreator,
          isLoading: isLoading,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
          onJoinTap: onJoinTap,
        ),
      ],
    );
  }
}