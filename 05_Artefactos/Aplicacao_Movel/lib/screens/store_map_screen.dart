import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/store/map/store_map_header.dart';
import '../widgets/store/map/store_map_search_bar.dart';
import '../widgets/store/map/store_map_game_filters.dart';
import '../widgets/store/map/store_map_preview_card.dart';
import '../widgets/store/map/store_nearby_players_header.dart';

class StoreMapScreen extends StatefulWidget {
  const StoreMapScreen({super.key});

  @override
  State<StoreMapScreen> createState() => _StoreMapScreenState();
}

class _StoreMapScreenState extends State<StoreMapScreen> {
  int _filter = 4;

  final List<(IconData, Color)> _games = const [
    (Icons.catching_pokemon, AppColors.pokemonGold),
    (Icons.change_history_rounded, AppColors.yugiohPurple),
    (Icons.local_fire_department_outlined, AppColors.magicOrange),
    (Icons.anchor_rounded, AppColors.onePieceBlue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreMapHeader(
                onNotificationTap: () {},
              ),
              const SizedBox(height: 18),
              const StoreMapSearchBar(),
              const SizedBox(height: 16),
              StoreMapGameFilters(
                games: _games,
                selectedFilter: _filter,
                onFilterChanged: (i) => setState(() => _filter = i),
              ),
              const SizedBox(height: 20),
              const StoreMapPreviewCard(),
              const SizedBox(height: 20),
              const StoreNearbyPlayersHeader(),
              const SizedBox(height: 12),
              const CompactPlayerCard(
                name: 'Maya Chen',
                subtitle: '0.8 mi · Competitive',
                avatarUrl: 'https://i.pravatar.cc/150?img=47',
                statusColor: AppColors.statusAvailable,
                gameIcon: Icons.catching_pokemon,
                gameColor: AppColors.pokemonGold,
                isHighlighted: true,
              ),
              const SizedBox(height: 12),
              const CompactPlayerCard(
                name: 'Jordan Brooks',
                subtitle: '2.1 mi · Casual',
                avatarUrl: 'https://i.pravatar.cc/150?img=11',
                statusColor: AppColors.statusOnline,
                gameIcon: Icons.anchor_rounded,
                gameColor: AppColors.onePieceBlue,
                isHighlighted: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}