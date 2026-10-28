import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/discover/discover_header.dart';
import '../widgets/discover/discover_search_bar.dart';
import '../widgets/discover/discover_game_filters.dart';
import '../widgets/discover/discover_map_preview.dart'; // Import do novo widget de mapa
import '../widgets/discover/discover_featured_event_card.dart';

/// [DiscoverScreen]
/// Ecrã principal de descoberta: Funciona como esqueleto estrutural,
/// integrando a pesquisa, filtros, mapa geolocalizado, jogadores próximos e eventos.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedGameFilter = 4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cabeçalho com indicador de localização e notificações
          DiscoverHeader(
            locationText: 'BROOKLYN · 3 PLAYERS NEARBY',
            onNotificationTap: () {},
          ),
          const SizedBox(height: 20),

          // 2. Barra de Pesquisa global
          const DiscoverSearchBar(),
          const SizedBox(height: 16),

          // 3. Filtros por Jogo TCG (Pokémon, Yu-Gi-Oh!, Magic, etc.)
          DiscoverGameFilters(
            selectedFilterIndex: _selectedGameFilter,
            onFilterSelected: (index) {
              setState(() => _selectedGameFilter = index);
            },
          ),
          const SizedBox(height: 20),

          // 4. Pré-visualização do Mapa (Preparado para futura API de geolocalização)
          const DiscoverMapPreview(),
          const SizedBox(height: 24),

          // 5. Cabeçalho da Lista de Jogadores Próximos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ready nearby',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 6. Cards compactos de jogadores detetados na zona
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
          const SizedBox(height: 16),

          // 7. Card em destaque com o evento/loja em evidência
          const DiscoverFeaturedEventCard(
            tag: 'MAGIC · TODAY',
            title: 'Friday\nNight\nCommander',
            storeDetails: 'Twenty Sided\nStore · 7 PM',
            seatsLeft: '6 seats left',
            imageUrl: 'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=400&q=80',
          ),
        ],
      ),
    );
  }
}