import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AppBottomNavItem {
  final IconData icon;
  final String label;
  final double iconSize;

  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.iconSize = 22,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavItem> items;
  final Color selectedColor;
  final double labelFontSize;
  final FontWeight selectedFontWeight;
  final double splashRadius;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.selectedColor,
    this.labelFontSize = 10.5,
    this.selectedFontWeight = FontWeight.w600,
    this.splashRadius = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.cardBorder,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 62,
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == currentIndex;
                final color =
                    isSelected ? selectedColor : AppColors.textSecondary;

                return Expanded(
                  child: InkResponse(
                    onTap: () => onTap(index),
                    radius: splashRadius,
                    containedInkWell: false,
                    highlightShape: BoxShape.circle,
                    splashFactory: InkRipple.splashFactory,
                    splashColor: selectedColor.withValues(alpha: 0.2),
                    highlightColor: selectedColor.withValues(alpha: 0.08),
                    child: SizedBox.expand(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: item.iconSize,
                            color: color,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: color,
                              fontSize: labelFontSize,
                              fontWeight: isSelected
                                  ? selectedFontWeight
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}