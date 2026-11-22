import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../discover/discover_game_filters.dart';

class EventsFiltersPanel extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> categories;
  final String selectedCategory;
  final Set<int> selectedGameFilterIndexes;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<int> onGameFilterToggled;

  const EventsFiltersPanel({
    super.key,
    required this.searchController,
    required this.categories,
    required this.selectedCategory,
    required this.selectedGameFilterIndexes,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onGameFilterToggled,
  });

  Widget _buildChip(String label) {
    final isSelected = selectedCategory == label;

    return Expanded(
      child: GestureDetector(
        onTap: () => onCategoryChanged(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primaryPurple : const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primaryPurple : Colors.white10,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search by tournament or creator...',
              hintStyle: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
              prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (int i = 0; i < categories.length; i++) ...[
                _buildChip(categories[i]),
                if (i < categories.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 12),
          DiscoverGameFilters(
            selectedFilterIndexes: selectedGameFilterIndexes,
            onFilterSelected: onGameFilterToggled,
          ),
        ],
      ),
    );
  }
}