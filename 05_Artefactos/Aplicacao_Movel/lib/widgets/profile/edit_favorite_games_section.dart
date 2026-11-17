import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'profile_favorite_games.dart';

class EditFavoriteGamesSection
    extends StatelessWidget {
  final Set<String> selectedGameIds;
  final ValueChanged<String> onToggle;

  const EditFavoriteGamesSection({
    super.key,
    required this.selectedGameIds,
    required this.onToggle,
  });

  Widget _buildGame(
    FavoriteGameOption game,
  ) {
    final selected =
        selectedGameIds.contains(game.id);

    return GestureDetector(
      onTap: () => onToggle(game.id),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration:
                      const Duration(
                    milliseconds: 150,
                  ),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        AppColors.surfaceLight,
                    border: Border.all(
                      color: selected
                          ? game.color
                          : AppColors
                              .cardBorder,
                      width:
                          selected ? 2.5 : 1.5,
                    ),
                  ),
                  child: Icon(
                    game.icon,
                    size: 24,
                    color: selected
                        ? game.color
                        : AppColors.textMuted,
                  ),
                ),

                if (selected)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor:
                          game.color,
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 7),

            Text(
              game.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : AppColors
                        .textSecondary,
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Favorite games',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 14),

        Wrap(
          spacing: 10,
          runSpacing: 14,
          children: kFavoriteGameOptions
              .map(_buildGame)
              .toList(),
        ),
      ],
    );
  }
}