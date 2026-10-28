import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// [PlayersSection]
/// Widget modular que agrupa a lista de jogadores ativos na vizinhança,
/// permitindo ver o seu estado de disponibilidade, biografia e emblemas dos TCGs jogados.
class PlayersSection extends StatelessWidget {
  const PlayersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título indicador da secção de utilizadores na proximidade
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
        
        // Cartaz detalhado do perfil do primeiro jogador (Maya Chen), com destaque visual ativo
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
        
        // Cartaz detalhado do perfil do segundo jogador (Jordan Brooks)
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
    );
  }
}