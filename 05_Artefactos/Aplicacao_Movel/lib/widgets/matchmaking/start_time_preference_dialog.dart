import 'package:flutter/material.dart';
import '../../models/match_preferences_model.dart';
import '../../theme/app_colors.dart';
import 'preference_dialog_shell.dart';

class StartTimePreferenceDialog extends StatelessWidget {
  final StartTimeOption currentStartTime;

  const StartTimePreferenceDialog({
    super.key,
    required this.currentStartTime,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceDialogShell(
      icon: Icons.access_time_rounded,
      title: 'Start Time',
      subtitle: 'When are you available to play?',
      content: Column(
        children: StartTimeOption.values.map((option) {
          final isSelected = option == currentStartTime;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryPurpleDark
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryPurple
                        : AppColors.cardBorder,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        option.label,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isSelected
                          ? AppColors.accentCyan
                          : AppColors.textMuted,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}