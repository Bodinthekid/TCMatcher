import '../models/player_profile_data.dart';
import '../theme/app_colors.dart';

const PlayerProfileData kMockMayaProfile = PlayerProfileData(
  key: 'maya',
  name: 'Maya Chen',
  username: 'mayacards',
  avatarUrl: 'https://i.pravatar.cc/150?img=47',
  statusLabel: 'Available to Play',
  statusColor: AppColors.statusAvailable,
  bio: 'Competitive Pokémon player and Commander fan. Usually playing after classes.',
  followers: 342,
  following: 118,
  favoriteGameIds: {'pokemon', 'magic'},
  weeklyMatches: 9,
  winRate: 78,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Eli R.',
      gameFormat: 'Pokémon · Standard',
      score: '2–0',
      dateLabel: 'Today',
    ),
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Nico S.',
      gameFormat: 'Pokémon · Standard',
      score: '2–1',
      dateLabel: 'Thu',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Jordan B.',
      gameFormat: 'Magic · Commander',
      score: '1–2',
      dateLabel: 'Tue',
    ),
  ],
  rating: 4.8,
  ratingCount: 19,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'eli',
      rating: 5,
      review: 'Very competitive but always friendly. Great games.',
    ),
    PlayerReviewData(
      reviewerKey: 'avery',
      rating: 4,
      review: 'Really good Pokémon player and very fair opponent.',
    ),
  ],
  tournaments: [
    PlayerTournamentData(
      title: 'Pokémon League Cup',
      game: 'Pokémon',
      date: 'Nov 8',
      result: '2nd',
      color: AppColors.pokemonGold,
    ),
    PlayerTournamentData(
      title: 'Regional Qualifier',
      game: 'Pokémon',
      date: 'Oct 18',
      result: 'Top 8',
      color: AppColors.pokemonGold,
    ),
  ],
);

const PlayerProfileData kMockJordanProfile = PlayerProfileData(
  key: 'jordan',
  name: 'Jordan Brooks',
  username: 'sideboardj',
  avatarUrl: 'https://i.pravatar.cc/150?img=11',
  statusLabel: 'Online',
  statusColor: AppColors.statusOnline,
  bio: 'Casual locals regular. Mostly One Piece and Yu-Gi-Oh!. Happy to teach new players.',
  followers: 87,
  following: 203,
  favoriteGameIds: {'one_piece', 'yugioh'},
  weeklyMatches: 4,
  winRate: 50,
  matches: [
    PlayerMatchData(
      isWin: true,
      opponent: 'vs. Maya C.',
      gameFormat: 'One Piece · Constructed',
      score: '2–1',
      dateLabel: 'Fri',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Avery K.',
      gameFormat: 'Yu-Gi-Oh! · Advanced',
      score: '0–2',
      dateLabel: 'Wed',
    ),
    PlayerMatchData(
      isWin: false,
      opponent: 'vs. Nico S.',
      gameFormat: 'Yu-Gi-Oh! · Advanced',
      score: '1–2',
      dateLabel: 'Mon',
    ),
  ],
  rating: 4.6,
  ratingCount: 8,
  reviews: [
    PlayerReviewData(
      reviewerKey: 'maya',
      rating: 5,
      review: 'Very welcoming player. Great for casual matches.',
    ),
    PlayerReviewData(
      reviewerKey: 'nico',
      rating: 4,
      review: 'Easy to organise games with and always on time.',
    ),
  ],
  tournaments: [
    PlayerTournamentData(
      title: 'One Piece Store Tournament',
      game: 'One Piece',
      date: 'Oct 30',
      result: '7th',
      color: AppColors.onePieceBlue,
    ),
  ],
);