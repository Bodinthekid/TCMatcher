import 'package:flutter/material.dart';

class PlayerMatchData {
  final bool isWin;
  final String opponent;
  final String gameFormat;
  final String score;
  final String dateLabel;

  const PlayerMatchData({
    required this.isWin,
    required this.opponent,
    required this.gameFormat,
    required this.score,
    required this.dateLabel,
  });
}

class PlayerReviewData {
  final String reviewerKey;
  final int rating;
  final String review;

  const PlayerReviewData({
    required this.reviewerKey,
    required this.rating,
    required this.review,
  });
}

class PlayerTournamentData {
  final String title;
  final String game;
  final String date;
  final String result;
  final Color color;

  const PlayerTournamentData({
    required this.title,
    required this.game,
    required this.date,
    required this.result,
    required this.color,
  });
}

class PlayerProfileData {
  final String key;

  final String name;
  final String username;
  final String avatarUrl;

  final String statusLabel;
  final Color statusColor;

  final String bio;

  final int followers;
  final int following;

  final Set<String> favoriteGameIds;

  final int weeklyMatches;
  final int winRate;

  final List<PlayerMatchData> matches;

  final double rating;
  final int ratingCount;

  final List<PlayerReviewData> reviews;

  final List<PlayerTournamentData> tournaments;

  const PlayerProfileData({
    required this.key,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.statusLabel,
    required this.statusColor,
    required this.bio,
    required this.followers,
    required this.following,
    required this.favoriteGameIds,
    required this.weeklyMatches,
    required this.winRate,
    required this.matches,
    required this.rating,
    required this.ratingCount,
    required this.reviews,
    required this.tournaments,
  });
}