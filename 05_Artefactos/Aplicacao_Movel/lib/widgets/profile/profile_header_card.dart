import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Secção modular que lista os TCGs e formatos preferidos praticados pelo utilizador.
class ProfileFavoriteGames extends StatelessWidget {
  const ProfileFavoriteGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rótulo da secção com tipografia ciano em destaque
          Text(
            'FAVORITE GAMES',
            style: TextStyle(
              color: AppColors.accentCyan,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 14),
          // Lista flexível contendo as etiquetas (pills) de cada jogo favorito
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              GamePillChip(
                label: 'Pokémon (Standard)',
                icon: Icons.catching_pokemon,
                color: AppColors.pokemonGold,
              ),
              GamePillChip(
                label: 'Magic (Commander)',
                icon: Icons.local_fire_department_outlined,
                color: AppColors.magicOrange,
              ),
              GamePillChip(
                label: 'One Piece',
                icon: Icons.anchor_rounded,
                color: AppColors.onePieceBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}