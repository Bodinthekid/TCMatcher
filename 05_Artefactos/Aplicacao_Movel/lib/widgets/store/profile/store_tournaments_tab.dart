import 'package:flutter/material.dart';
import '../../../models/store_profile_data.dart';
import '../../../theme/app_colors.dart';
import 'store_tournament_card.dart';

class StoreTournamentsTab extends StatelessWidget {
  final StoreProfileData storeData;

  const StoreTournamentsTab({
    super.key,
    required this.storeData,
  });

  Widget _buildQuickStat({required String value, required String label}) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Store overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildQuickStat(
              value: storeData.tournaments.length.toString(),
              label: 'upcoming',
            ),
            const SizedBox(width: 10),
            _buildQuickStat(
              value: storeData.tablesCount.toString(),
              label: 'play tables',
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming tournaments',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${storeData.tournaments.length} scheduled',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (storeData.tournaments.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Text(
              'No upcoming tournaments scheduled',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
            ),
          )
        else
          ...storeData.tournaments.map((t) => StoreTournamentCard(tournament: t)),
      ],
    );
  }
}