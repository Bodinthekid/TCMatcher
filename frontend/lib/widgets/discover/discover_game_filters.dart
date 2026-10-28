import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

class DiscoverGameFilters extends StatelessWidget {
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterSelected;

  const DiscoverGameFilters({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularGameIcon(
          icon: Icons.catching_pokemon,
          color: AppColors.pokemonGold,
          isSelected: selectedFilterIndex == 0,
          onTap: () => onFilterSelected(0),
        ),
        const SizedBox(width: 10),
        CircularGameIcon(
          icon: Icons.change_history_rounded,
          color: AppColors.yugiohPurple,
          isSelected: selectedFilterIndex == 1,
          onTap: () => onFilterSelected(1),
        ),
        const SizedBox(width: 10),
        CircularGameIcon(
          icon: Icons.local_fire_department_outlined,
          color: AppColors.magicOrange,
          isSelected: selectedFilterIndex == 2,
          onTap: () => onFilterSelected(2),
        ),
        const SizedBox(width: 10),
        CircularGameIcon(
          icon: Icons.anchor_rounded,
          color: AppColors.onePieceBlue,
          isSelected: selectedFilterIndex == 3,
          onTap: () => onFilterSelected(3),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => onFilterSelected(4),
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedFilterIndex == 4
                  ? AppColors.primaryPurple
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedFilterIndex == 4
                    ? AppColors.primaryPurple
                    : AppColors.cardBorder,
              ),
            ),
            child: const Text(
              'All',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}