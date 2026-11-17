import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

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

const List<FavoriteGameOption>
    kFavoriteGameOptions = [
  FavoriteGameOption(
    id: 'pokemon',
    label: 'Pokémon',
    icon: Icons.catching_pokemon,
    color: AppColors.pokemonGold,
  ),

  FavoriteGameOption(
    id: 'magic',
    label: 'Magic',
    icon:
        Icons.local_fire_department_outlined,
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
    icon:
        Icons.change_history_rounded,
    color: AppColors.yugiohPurple,
  ),
];

class ProfileFavoriteGames
    extends StatelessWidget {
  static final ValueNotifier<
      Set<String>> selectedGameIds =
      ValueNotifier<Set<String>>({
    'pokemon',
    'magic',
    'one_piece',
    'yugioh',
  });

  final bool isEditable;

  final Set<String>? gameIds;

  const ProfileFavoriteGames({
    super.key,
    this.isEditable = false,
    this.gameIds,
  });

  Widget _buildGame(
    FavoriteGameOption game,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        right: 14,
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(
                color: game.color,
                width: 2,
              ),
            ),
            child: Icon(
              game.icon,
              color: game.color,
              size: 24,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            game.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGames(
    Set<String> selectedIds,
  ) {
    final games =
        kFavoriteGameOptions
            .where(
              (game) =>
                  selectedIds
                      .contains(game.id),
            )
            .toList();

    if (games.isEmpty) {
      return const Text(
        'No favorite games selected',
        style: TextStyle(
          color:
              AppColors.textSecondary,
          fontSize: 12,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection:
          Axis.horizontal,
      child: Row(
        children:
            games.map(_buildGame).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (gameIds != null) {
      return _buildGames(
        gameIds!,
      );
    }

    return ValueListenableBuilder<
        Set<String>>(
      valueListenable:
          selectedGameIds,
      builder: (
        context,
        selectedIds,
        _,
      ) {
        return _buildGames(
          selectedIds,
        );
      },
    );
  }
}