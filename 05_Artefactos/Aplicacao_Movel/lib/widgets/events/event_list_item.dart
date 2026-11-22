import 'package:flutter/material.dart';
import '../discover/discover_featured_event_card.dart';

class EventListItem extends StatelessWidget {
  final dynamic tournament;
  final VoidCallback onTap;

  const EventListItem({
    super.key,
    required this.tournament,
    required this.onTap,
  });

  String _formatDateLabel(bool isPrivate) {
    final rawStartTime = tournament['start_time'];
    if (rawStartTime == null) {
      return isPrivate ? 'PRIVATE' : 'TODAY';
    }

    try {
      final dt = DateTime.parse(rawStartTime.toString()).toLocal();
      final formatted = '${dt.day.toString().padLeft(2, '0')}/'
          '${dt.month.toString().padLeft(2, '0')}'
          ' • '
          '${dt.hour.toString().padLeft(2, '0')}:'
          '${dt.minute.toString().padLeft(2, '0')}';

      return isPrivate ? '$formatted (PRIVATE)' : formatted;
    } catch (_) {
      return isPrivate ? 'PRIVATE' : 'TODAY';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPrivate = tournament['is_private'] == 1;
    final gameName = (tournament['game_name'] ?? 'TCG').toString();
    final organizerName =
        (tournament['organizer_name'] ?? 'Unknown Creator').toString();
    final location = isPrivate
        ? 'Private Location (Invite Only)'
        : (tournament['location_name'] ?? 'Location not specified').toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: DiscoverFeaturedEventCard(
          tag: '${gameName.toUpperCase()} • ${_formatDateLabel(isPrivate)}',
          title: (tournament['title'] ?? 'Tournament').toString(),
          storeDetails: 'By $organizerName\n$location',
          seatsLeft: '${tournament['max_slots'] ?? 8} max slots',
          gameId: tournament['game_id'],
        ),
      ),
    );
  }
}