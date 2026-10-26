import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STORE EVENT CARDS',
            style: TextStyle(
              color: AppColors.accentCyan,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 12),
          DetailedStoreEventCard(
            gameName: 'Magic',
            gameIcon: Icons.local_fire_department_outlined,
            gameColor: AppColors.magicOrange,
            title: 'Friday Night Commander',
            storeLocation: 'Twenty Sided Store · Brooklyn',
            dateTime: 'Oct 9 · 7:00 PM',
            spotsInfo: 'Casual pods · 6 left',
            imageUrl:
                'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=400&q=80',
          ),
          SizedBox(height: 14),
          DetailedStoreEventCard(
            gameName: 'Pokémon',
            gameIcon: Icons.catching_pokemon,
            gameColor: AppColors.pokemonGold,
            title: 'Pokémon League Challenge',
            storeLocation: 'Next Level Games · Queens',
            dateTime: 'Oct 11 · 12:30 PM',
            spotsInfo: 'Standard · 12 spots',
            imageUrl:
                'https://images.unsplash.com/photo-1606167668584-78701c57f13d?auto=format&fit=crop&w=400&q=80',
          ),
          SizedBox(height: 28),
          Text(
            'PLAYER CARDS',
            style: TextStyle(
              color: AppColors.accentCyan,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 12),
          DetailedPlayerCard(
            name: 'Maya Chen',
            handleAndDistance: '@mayacards · 0.8 mi',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
            statusLabel: 'Available to Play',
            statusColor: AppColors.statusAvailable,
            bio: 'Competitive Standard · casual Commander',
            gameBadges: [
              GameBadgeData(Icons.catching_pokemon, AppColors.pokemonGold),
              GameBadgeData(
                  Icons.local_fire_department_outlined, AppColors.magicOrange),
            ],
            isHighlighted: true,
          ),
          SizedBox(height: 14),
          DetailedPlayerCard(
            name: 'Jordan Brooks',
            handleAndDistance: '@sideboardj · 2.1 mi',
            avatarUrl: 'https://i.pravatar.cc/150?img=11',
            statusLabel: 'Online',
            statusColor: AppColors.statusOnline,
            bio: 'Locals regular · teaching new players',
            gameBadges: [
              GameBadgeData(
                  Icons.change_history_rounded, AppColors.yugiohPurple),
              GameBadgeData(Icons.anchor_rounded, AppColors.onePieceBlue),
            ],
            isHighlighted: false,
          ),
        ],
      ),
    );
  }
}