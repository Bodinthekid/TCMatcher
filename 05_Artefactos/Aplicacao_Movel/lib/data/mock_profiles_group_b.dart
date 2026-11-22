import '../models/player_profile_data.dart';
import '../theme/app_colors.dart';

const PlayerProfileData kMockEliProfile = PlayerProfileData(
  key: 'eli',
  name: 'Eli Rivera',
  username: 'elirivera',
  avatarUrl: 'https://i.pravatar.cc/150?img=12',
  statusLabel: 'Available to Play',
  statusColor: AppColors.statusAvailable,
  bio: 'Competitive Magic player. Grinding tournaments and always looking for strong practice games.',
  followers: 521,
  following: 76,
  favoriteGameIds: {'magic'},
  weeklyMatches: 12,
  winRate: 83,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Avery K.',
      gameFormat: 'Magic · Modern',
      score: '2–0',
      dateLabel: 'Today',
    ),
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Maya C.',
      gameFormat: 'Magic · Commander',
      score: '2–1',
      dateLabel: 'Sat',
    ),
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Jordan B.',
      gameFormat: 'Magic · Modern',
      score: '2–0',
      dateLabel: 'Thu',
    ),
  ],
  rating: 4.9,
  ratingCount: 24,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'maya',
      rating: 5,
      review: 'Excellent player. Very competitive without making the game unpleasant.',
    ),
    PlayerReviewData(
      reviewerKey: 'jordan',
      rating: 5,
      review: 'Helped me understand several mistakes after our match.',
    ),
  ],
  tournaments: [
    PlayerTournamentData(
      title: 'Modern Championship',
      game: 'Magic',
      date: 'Nov 10',
      result: '1st',
      color: AppColors.magicOrange,
    ),
    PlayerTournamentData(
      title: 'Friday Night Magic',
      game: 'Magic',
      date: 'Nov 1',
      result: '1st',
      color: AppColors.magicOrange,
    ),
    PlayerTournamentData(
      title: 'Store Championship',
      game: 'Magic',
      date: 'Oct 14',
      result: '3rd',
      color: AppColors.magicOrange,
    ),
  ],
);

const PlayerProfileData kMockNicoProfile = PlayerProfileData(
  key: 'nico',
  name: 'Nico Santos',
  username: 'nicosantos',
  avatarUrl: 'https://i.pravatar.cc/150?img=5',
  statusLabel: 'Offline',
  statusColor: AppColors.statusOffline,
  bio: 'Collector first, player second. Pokémon and Yu-Gi-Oh! on weekends.',
  followers: 64,
  following: 151,
  favoriteGameIds: {'pokemon', 'yugioh'},
  weeklyMatches: 2,
  winRate: 50,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Jordan B.',
      gameFormat: 'Yu-Gi-Oh! · Advanced',
      score: '2–1',
      dateLabel: 'Sat',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Maya C.',
      gameFormat: 'Pokémon · Standard',
      score: '1–2',
      dateLabel: 'Thu',
    ),
  ],
  rating: 4.2,
  ratingCount: 5,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'jordan',
      rating: 4,
      review: 'Relaxed player and fun to play against.',
    ),
    PlayerReviewData(
      reviewerKey: 'avery',
      rating: 4,
      review: 'Good sportsmanship and very chill games.',
    ),
  ],
  tournaments: [],
);