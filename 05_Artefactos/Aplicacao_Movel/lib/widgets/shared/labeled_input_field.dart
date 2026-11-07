import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LabeledInputField extends StatelessWidget {
  final String label;
  final String hintOrValue;
  final IconData prefixIcon;
  final bool isPlaceholder;
  final Color? borderColor;
  final Color? iconColor;
  final IconData? trailingIcon;
  final Color? trailingColor;

  const LabeledInputField({
    super.key,
    required this.label,
    required this.hintOrValue,
    required this.prefixIcon,
    this.isPlaceholder = false,
    this.borderColor,
    this.iconColor,
    this.trailingIcon,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor ?? AppColors.cardBorder,
              width: borderColor != null ? 1.4 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                prefixIcon,
                color: iconColor ?? AppColors.textSecondary,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hintOrValue,
                  style: TextStyle(
                    color: isPlaceholder ? AppColors.textMuted : Colors.white,
                    fontSize: 13.5,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: trailingColor ?? AppColors.textSecondary,
                  size: 18,
                ),
            ],
          ),
        ),
      ],
    );
  }
}