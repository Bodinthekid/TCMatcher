import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class RailItemButton extends StatelessWidget {
  final bool isSelected;
  final bool hasUnread;
  final VoidCallback onTap;
  final Widget child;

  const RailItemButton({
    super.key,
    required this.isSelected,
    required this.hasUnread,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 4,
                height: isSelected ? 34 : (hasUnread ? 8 : 0),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accentCyan : Colors.white,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(4),
                  ),
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: isSelected ? 15 : 23),
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              builder: (_, radius, innerChild) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: SizedBox(
                    width: 46,
                    height: 46,
                    child: innerChild,
                  ),
                );
              },
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}