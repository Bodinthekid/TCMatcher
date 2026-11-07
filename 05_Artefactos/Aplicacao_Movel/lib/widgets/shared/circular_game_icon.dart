import 'package:flutter/material.dart';

class CircularGameIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const CircularGameIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: isSelected ? 0.25 : 0.12),
          shape: BoxShape.circle,
          border: Border.all(
            color: color.withValues(alpha: isSelected ? 1.0 : 0.6),
            width: 1.4,
          ),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}