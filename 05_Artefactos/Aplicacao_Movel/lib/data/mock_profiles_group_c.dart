import '../models/player_profile_data.dart';
import '../theme/app_colors.dart';

const PlayerProfileData kMockAveryProfile = PlayerProfileData(
  key: 'avery',
  name: 'Avery Kim',
  username: 'averykim',
  avatarUrl: 'https://i.pravatar.cc/150?img=33',
  statusLabel: 'Online',
  statusColor: AppColors.statusOnline,
  bio: 'One Piece specialist who also plays Magic and Yu-Gi-Oh!. Usually at locals every week.',
  followers: 196,
  following: 134,
  favoriteGameIds: {'one_piece', 'magic', 'yugioh'},
  weeklyMatches: 7,
  winRate: 71,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Jordan B.',
      gameFormat: 'Yu-Gi-Oh! · Advanced',
      score: '2–0',
      dateLabel: 'Today',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Eli R.',
      gameFormat: 'Magic · Modern',
      score: '0–2',
      dateLabel: 'Fri',
    ),
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Nico S.',
      gameFormat: 'One Piece · Constructed',
      score: '2–1',
      dateLabel: 'Tue',
    ),
  ],
  rating: 4.7,
  ratingCount: 13,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'eli',
      rating: 5,
      review: 'Strong player with excellent game knowledge.',
    ),
    PlayerReviewData(
      reviewerKey: 'nico',
      rating: 4,
      review: 'Friendly and always willing to play another round.',
    ),
  ],
  tournaments: [
    PlayerTournamentData(
      title: 'One Piece Championship',
      game: 'One Piece',
      date: 'Nov 5',
      result: '3rd',
      color: AppColors.onePieceBlue,
    ),
    PlayerTournamentData(
      title: 'Yu-Gi-Oh! Locals',
      game: 'Yu-Gi-Oh!',
      date: 'Oct 21',
      result: '4th',
      color: AppColors.yugiohPurple,
    ),
  ],
);

const PlayerProfileData kMockCurrentUserFallback = PlayerProfileData(
  key: 'current',
  name: 'Player',
  username: 'player',
  avatarUrl: 'https://i.pravatar.cc/150?img=47',
  statusLabel: 'Available to Play',
  statusColor: AppColors.statusAvailable,
  bio: '',
  followers: 128,
  following: 94,
  favoriteGameIds: {'pokemon', 'magic', 'one_piece', 'yugioh'},
  weeklyMatches: 11,
  winRate: 73,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Eli R.',
      gameFormat: 'Magic · Commander',
      score: '2–1',
      dateLabel: 'Today',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Nico S.',
      gameFormat: 'Pokémon · Standard',
      score: '1–2',
      dateLabel: 'Wed',
    ),
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Avery K.',
      gameFormat: 'One Piece · Constructed',
      score: '2–0',
      dateLabel: 'Mon',
    ),
  ],
  rating: 4.9,
  ratingCount: 12,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'eli',
      rating: 5,
      review: 'Great opponent. Friendly and fair throughout the match.',
    ),
    PlayerReviewData(
      reviewerKey: 'nico',
      rating: 5,
      review: 'Very respectful player and easy to arrange a match with.',
    ),
    PlayerReviewData(
      reviewerKey: 'avery',
      rating: 4,
      review: 'Good match and great sportsmanship.',
    ),
  ],
  tournaments: [
    PlayerTournamentData(
      title: 'Friday Night Commander',
      game: 'Magic',
      date: 'Nov 8',
      result: '3rd',
      color: AppColors.magicOrange,
    ),
    PlayerTournamentData(
      title: 'Store League',
      game: 'Pokémon',
      date: 'Oct 26',
      result: '5th',
      color: AppColors.pokemonGold,
    ),
  ],
);