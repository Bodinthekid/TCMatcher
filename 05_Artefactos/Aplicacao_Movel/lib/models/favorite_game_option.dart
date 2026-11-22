import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FavoriteGameOption {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const FavoriteGameOption({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}

const List<FavoriteGameOption> kFavoriteGameOptions = [
  FavoriteGameOption(
    id: 'pokemon',
    label: 'Pokémon',
    icon: Icons.catching_pokemon,
    color: AppColors.pokemonGold,
  ),
  FavoriteGameOption(
    id: 'magic',
    label: 'Magic',
    icon: Icons.local_fire_department_outlined,
    color: AppColors.magicOrange,
  ),
  FavoriteGameOption(
    id: 'one_piece',
    label: 'One Piece',
    icon: Icons.anchor_rounded,
    color: AppColors.onePieceBlue,
  ),
  FavoriteGameOption(
    id: 'yugioh',
    label: 'Yu-Gi-Oh!',
    icon: Icons.change_history_rounded,
    color: AppColors.yugiohPurple,
  ),
];