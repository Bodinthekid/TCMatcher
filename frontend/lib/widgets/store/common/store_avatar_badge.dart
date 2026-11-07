import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreAvatarBadge extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool isCircle;

  const StoreAvatarBadge({
    super.key,
    this.text = 'MV',
    this.size = 36,
    this.color = AppColors.primaryPurple,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCircle ? color.withValues(alpha: 0.22) : color,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(size * 0.28),
        border: Border.all(
          color: isCircle ? color.withValues(alpha: 0.6) : AppColors.background,
          width: isCircle ? 1.2 : 2.5,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isCircle ? color : Colors.white,
          fontSize: size * 0.35,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}