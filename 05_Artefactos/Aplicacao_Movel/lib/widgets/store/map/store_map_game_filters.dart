import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/circular_game_icon.dart';

class StoreMapGameFilters extends StatelessWidget {
  final List<(IconData, Color)> games;
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  const StoreMapGameFilters({
    super.key,
    required this.games,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          games.length,
          (i) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircularGameIcon(
              icon: games[i].$1,
              color: games[i].$2,
              isSelected: selectedFilter == i,
              onTap: () => onFilterChanged(i),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onFilterChanged(games.length),
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedFilter == games.length
                  ? AppColors.primaryPurple
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedFilter == games.length
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