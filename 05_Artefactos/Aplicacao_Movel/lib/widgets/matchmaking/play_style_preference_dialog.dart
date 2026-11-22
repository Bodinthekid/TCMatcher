import 'package:flutter/material.dart';
import '../../models/match_preferences_model.dart';
import '../../theme/app_colors.dart';
import 'preference_dialog_shell.dart';

class PlayStylePreferenceDialog extends StatelessWidget {
  final PlayStyleOption currentPlayStyle;

  const PlayStylePreferenceDialog({
    super.key,
    required this.currentPlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceDialogShell(
      icon: Icons.people_outline_rounded,
      title: 'Play Style',
      subtitle: 'Choose the vibe for your next match',
      content: Column(
        children: PlayStyleOption.values.map((option) {
          final isSelected = option == currentPlayStyle;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(option),
              child: Container(
                padding: const EdgeInsets.all(14),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            option.description,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
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