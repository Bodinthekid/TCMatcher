import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../theme/app_colors.dart';
import 'discover_game_filters.dart';

/// Painel superior flutuante com barra de pesquisa, filtros de jogo e estado de disponibilidade.
class DiscoverTopPanel extends StatelessWidget {
  final FocusNode searchFocusNode;
  final bool isTopExpanded;
  final Set<int> selectedGameFilters;
  final bool availableToPlay;
  final VoidCallback onToggleTopPanel;
  final ValueChanged<int> onFilterSelected;
  final ValueChanged<bool> onAvailableToPlayChanged;

  const DiscoverTopPanel({
    super.key,
    required this.searchFocusNode,
    required this.isTopExpanded,
    required this.selectedGameFilters,
    required this.availableToPlay,
    required this.onToggleTopPanel,
    required this.onFilterSelected,
    required this.onAvailableToPlayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PointerInterceptor(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.cardBorder.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildCollapsibleFilters(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white60,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              focusNode: searchFocusNode,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Find players or stores',
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onToggleTopPanel,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.cardBorder,
                ),
              ),
              child: AnimatedRotation(
                turns: isTopExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 220),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.accentCyan,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsibleFilters() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        maxHeight: isTopExpanded ? 150 : 0,
      ),
      child: ClipRect(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              DiscoverGameFilters(
                selectedFilterIndexes: selectedGameFilters,
                onFilterSelected: onFilterSelected,
              ),
              const SizedBox(height: 12),
              _buildAvailableSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: AppColors.statusAvailable,
            size: 10,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Available to Play',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch.adaptive(
            value: availableToPlay,
            activeColor: AppColors.accentCyan,
            onChanged: onAvailableToPlayChanged,
          ),
        ],
      ),
    );
  }
}