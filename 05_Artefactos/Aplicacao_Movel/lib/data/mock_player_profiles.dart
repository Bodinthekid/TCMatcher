import '../models/player_profile_data.dart';
import '../theme/app_colors.dart';

class MockPlayerProfiles {
  static const maya = PlayerProfileData(
    key: 'maya',
    name: 'Maya Chen',
    username: 'mayacards',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    statusLabel: 'Available to Play',
    statusColor: AppColors.statusAvailable,
    bio:
        'Competitive Pokémon player and Commander fan. Usually playing after classes.',
    followers: 342,
    following: 118,
    favoriteGameIds: {
      'pokemon',
      'magic',
    },
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
        review:
            'Very competitive but always friendly. Great games.',
      ),
      PlayerReviewData(
        reviewerKey: 'avery',
        rating: 4,
        review:
            'Really good Pokémon player and very fair opponent.',
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

  static const jordan = PlayerProfileData(
    key: 'jordan',
    name: 'Jordan Brooks',
    username: 'sideboardj',
    avatarUrl: 'https://i.pravatar.cc/150?img=11',
    statusLabel: 'Online',
    statusColor: AppColors.statusOnline,
    bio:
        'Casual locals regular. Mostly One Piece and Yu-Gi-Oh!. Happy to teach new players.',
    followers: 87,
    following: 203,
    favoriteGameIds: {
      'one_piece',
      'yugioh',
    },
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
        review:
            'Very welcoming player. Great for casual matches.',
      ),
      PlayerReviewData(
        reviewerKey: 'nico',
        rating: 4,
        review:
            'Easy to organise games with and always on time.',
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

  static const eli = PlayerProfileData(
    key: 'eli',
    name: 'Eli Rivera',
    username: 'elirivera',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    statusLabel: 'Available to Play',
    statusColor: AppColors.statusAvailable,
    bio:
        'Competitive Magic player. Grinding tournaments and always looking for strong practice games.',
    followers: 521,
    following: 76,
    favoriteGameIds: {
      'magic',
    },
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
        review:
            'Excellent player. Very competitive without making the game unpleasant.',
      ),
      PlayerReviewData(
        reviewerKey: 'jordan',
        rating: 5,
        review:
            'Helped me understand several mistakes after our match.',
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

  static const nico = PlayerProfileData(
    key: 'nico',
    name: 'Nico Santos',
    username: 'nicosantos',
    avatarUrl: 'https://i.pravatar.cc/150?img=5',
    statusLabel: 'Offline',
    statusColor: AppColors.statusOffline,
    bio:
        'Collector first, player second. Pokémon and Yu-Gi-Oh! on weekends.',
    followers: 64,
    following: 151,
    favoriteGameIds: {
      'pokemon',
      'yugioh',
    },
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
        review:
            'Relaxed player and fun to play against.',
      ),
      PlayerReviewData(
        reviewerKey: 'avery',
        rating: 4,
        review:
            'Good sportsmanship and very chill games.',
      ),
    ],
    tournaments: [],
  );

  static const avery = PlayerProfileData(
    key: 'avery',
    name: 'Avery Kim',
    username: 'averykim',
    avatarUrl: 'https://i.pravatar.cc/150?img=33',
    statusLabel: 'Online',
    statusColor: AppColors.statusOnline,
    bio:
        'One Piece specialist who also plays Magic and Yu-Gi-Oh!. Usually at locals every week.',
    followers: 196,
    following: 134,
    favoriteGameIds: {
      'one_piece',
      'magic',
      'yugioh',
    },
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
        review:
            'Strong player with excellent game knowledge.',
      ),
      PlayerReviewData(
        reviewerKey: 'nico',
        rating: 4,
        review:
            'Friendly and always willing to play another round.',
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

  static const currentUserFallback = PlayerProfileData(
    key: 'current',
    name: 'Player',
    username: 'player',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    statusLabel: 'Available to Play',
    statusColor: AppColors.statusAvailable,
    bio: '',
    followers: 128,
    following: 94,
    favoriteGameIds: {
      'pokemon',
      'magic',
      'one_piece',
      'yugioh',
    },
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
        review:
            'Great opponent. Friendly and fair throughout the match.',
      ),
      PlayerReviewData(
        reviewerKey: 'nico',
        rating: 5,
        review:
            'Very respectful player and easy to arrange a match with.',
      ),
      PlayerReviewData(
        reviewerKey: 'avery',
        rating: 4,
        review:
            'Good match and great sportsmanship.',
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

  static const List<PlayerProfileData> all = [
    maya,
    jordan,
    eli,
    nico,
    avery,
  ];

  static PlayerProfileData? byKey(
    String key,
  ) {
    for (final profile in all) {
      if (profile.key == key) {
        return profile;
      }
    }

    return null;
  }

  static PlayerProfileData? byName(
    String? name,
  ) {
    if (name == null) {
      return null;
    }

    final normalizedName =
        name.trim().toLowerCase();

    for (final profile in all) {
      if (profile.name.toLowerCase() ==
          normalizedName) {
        return profile;
      }
    }

    return null;
  }
}