import 'package:flutter/material.dart';
import 'player_profile_data.dart';
import '../theme/app_colors.dart';

class StoreTournamentData {
  final String title;
  final String game;
  final String date;
  final String fee;
  final String spots;
  final Color color;

  const StoreTournamentData({
    required this.title,
    required this.game,
    required this.date,
    required this.fee,
    required this.spots,
    required this.color,
  });
}

class StoreProfileData {
  final String name;
  final String username;
  final String avatarUrl;
  final String bannerUrl;
  final String bio;
  final String address;
  final String openingHours;
  final String phone;
  final int tablesCount;
  final List<StoreTournamentData> tournaments;
  final double rating;
  final int ratingCount;
  final List<PlayerReviewData> reviews;

  const StoreProfileData({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.bannerUrl,
    required this.bio,
    required this.address,
    required this.openingHours,
    required this.phone,
    required this.tablesCount,
    required this.tournaments,
    required this.rating,
    required this.ratingCount,
    required this.reviews,
  });

  StoreProfileData copyWith({
    String? name,
    String? username,
    String? avatarUrl,
    String? bannerUrl,
    String? bio,
    String? address,
    String? openingHours,
    String? phone,
  }) {
    return StoreProfileData(
      name: name ?? this.name,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      openingHours: openingHours ?? this.openingHours,
      phone: phone ?? this.phone,
      tablesCount: tablesCount,
      tournaments: tournaments,
      rating: rating,
      ratingCount: ratingCount,
      reviews: reviews,
    );
  }

  static const StoreProfileData defaultStore = StoreProfileData(
    name: 'Mana Vault Games',
    username: 'manavault',
    avatarUrl: 'https://i.pravatar.cc/150?img=68',
    bannerUrl:
        'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=900&q=80',
    bio: 'Local TCG hub for weekly tournaments, casual tables, and singles trading.',
    address: 'Av. da Liberdade 142, Lisboa',
    openingHours: 'Tue – Sun · 11:00 – 22:00',
    phone: '+351 213 456 789',
    tablesCount: 16,
    tournaments: [
      StoreTournamentData(
        title: 'One Piece Local Championship',
        game: 'One Piece',
        date: 'Sat, Oct 3 · 2:00 PM',
        fee: '€10',
        spots: '18/24',
        color: AppColors.onePieceBlue,
      ),
      StoreTournamentData(
        title: 'Pokémon League Challenge',
        game: 'Pokémon',
        date: 'Sun, Oct 4 · 11:00 AM',
        fee: '€5',
        spots: '20/32',
        color: AppColors.pokemonGold,
      ),
      StoreTournamentData(
        title: 'Friday Night Commander Pods',
        game: 'Magic',
        date: 'Fri, Oct 9 · 7:00 PM',
        fee: 'Free',
        spots: '10/16',
        color: AppColors.magicOrange,
      ),
    ],
    rating: 4.8,
    ratingCount: 36,
    reviews: [
      PlayerReviewData(
        reviewerKey: 'maya',
        rating: 5,
        review: 'Well organized events, plenty of table space, and welcoming staff.',
      ),
      PlayerReviewData(
        reviewerKey: 'eli',
        rating: 5,
        review: 'Great competitive crowd for Friday Night Magic and fair prize support.',
      ),
      PlayerReviewData(
        reviewerKey: 'jordan',
        rating: 4,
        review: 'Chill atmosphere for casual games and easy to find people to trade with.',
      ),
    ],
  );
}