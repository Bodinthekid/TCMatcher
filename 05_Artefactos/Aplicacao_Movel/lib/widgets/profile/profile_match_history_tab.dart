import 'package:flutter/material.dart';
import '../../models/player_profile_data.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

class ProfileMatchHistoryTab extends StatelessWidget {
  final PlayerProfileData profileData;

  const ProfileMatchHistoryTab({
    super.key,
    required this.profileData,
  });

  Widget _buildWeeklyStat({required String value, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
    if (profileData.matches.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: const Text(
          'No matches recorded yet',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: List.generate(profileData.matches.length, (index) {
          final match = profileData.matches[index];
          return Column(
            children: [
              MatchLogRow(
                isWin: match.isWin,
                opponent: match.opponent,
                gameFormat: match.gameFormat,
                score: match.score,
                dateLabel: match.dateLabel,
              ),
              if (index < profileData.matches.length - 1)
                const Divider(color: AppColors.cardBorder, height: 1),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This week',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildWeeklyStat(
              value: profileData.weeklyMatches.toString(),
              label: 'matches',
            ),
            const SizedBox(width: 10),
            _buildWeeklyStat(
              value: '${profileData.winRate}%',
              label: 'win rate',
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'Match history',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        _buildHistory(),
      ],
    );
  }
}