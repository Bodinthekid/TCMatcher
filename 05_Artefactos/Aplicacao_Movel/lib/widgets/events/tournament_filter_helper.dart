import 'package:flutter/material.dart';

class TournamentFilterHelper {
  static const Map<int, int> filterIndexToGameId = {
    0: 2,
    1: 4,
    2: 1,
    3: 3,
  };

  static List<dynamic> filter({
    required List<dynamic> tournaments,
    required String query,
    required String selectedCategory,
    required Set<int> selectedGameIndexes,
    String? currentUserId,
  }) {
    final normalizedQuery = query.toLowerCase();
    final selectedGameIds = selectedGameIndexes
        .map((i) => filterIndexToGameId[i])
        .whereType<int>()
        .toSet();

    return tournaments.where((t) {
      final isPrivate = t['is_private'] == 1;

      final matchesCategory = switch (selectedCategory) {
        'Mine' => currentUserId != null &&
            t['organizer_id']?.toString() == currentUserId,
        'Public' => !isPrivate,
        'Private' => isPrivate,
        _ => true,
      };

      final gameId = t['game_id'] is int
          ? t['game_id'] as int
          : int.tryParse(t['game_id']?.toString() ?? '');

      final matchesGame = selectedGameIds.isEmpty ||
          (gameId != null && selectedGameIds.contains(gameId));

      final title = (t['title'] ?? '').toString().toLowerCase();
      final organizer = (t['organizer_name'] ?? '').toString().toLowerCase();
      final matchesSearch =
          title.contains(normalizedQuery) || organizer.contains(normalizedQuery);

      return matchesCategory && matchesGame && matchesSearch;
    }).toList();
  }

  static Future<T?> showEventModal<T>(BuildContext context, Widget child) {
    return showDialog<T>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: child,
        ),
      ),
    );
  }
}