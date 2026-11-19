
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

class DiscoverGameFilters extends StatelessWidget {
  final Set<int> selectedFilterIndexes;
  final ValueChanged<int> onFilterSelected;
  final VoidCallback? onAdvancedFilterTap;

  const DiscoverGameFilters({
    super.key,
    required this.selectedFilterIndexes,
    required this.onFilterSelected,
    this.onAdvancedFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'icon': Icons.catching_pokemon,
        'color': AppColors.pokemonGold,
      },
      {
        'icon': Icons.change_history_rounded,
        'color': AppColors.yugiohPurple,
      },
      {
        'icon': Icons.local_fire_department_outlined,
        'color': AppColors.magicOrange,
      },
      {
        'icon': Icons.anchor_rounded,
        'color': AppColors.onePieceBlue,
      },
    ];

    return Row(
      children: [
        ...List.generate(games.length, (index) {
          final isSelected = selectedFilterIndexes.contains(index);

          final originalColor = games[index]['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircularGameIcon(
              icon: games[index]['icon'] as IconData,
              color: isSelected ? originalColor : Colors.white24,
              isSelected: isSelected,
              onTap: () => onFilterSelected(index),
            ),
          );
        }),

        const Spacer(),

        GestureDetector(
          onTap: onAdvancedFilterTap ?? () {},
          child: Container(
            height: 38,
            width: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.cardBorder,
              ),
            ),
            child: const Icon(
              Icons.tune,
              color: AppColors.accentCyan,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
