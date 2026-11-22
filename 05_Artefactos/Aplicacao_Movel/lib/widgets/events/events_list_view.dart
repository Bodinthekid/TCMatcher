import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'event_list_item.dart';

class EventsListView extends StatelessWidget {
  final bool isLoading;
  final List<dynamic> tournaments;
  final Future<void> Function() onRefresh;
  final ValueChanged<dynamic> onTournamentTap;

  const EventsListView({
    super.key,
    required this.isLoading,
    required this.tournaments,
    required this.onRefresh,
    required this.onTournamentTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryPurple),
      );
    }

    if (tournaments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No tournaments found matching your criteria.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryPurple,
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: tournaments.length,
        itemBuilder: (_, index) {
          final tournament = tournaments[index];
          return EventListItem(
            tournament: tournament,
            onTap: () => onTournamentTap(tournament),
          );
        },
      ),
    );
  }
}