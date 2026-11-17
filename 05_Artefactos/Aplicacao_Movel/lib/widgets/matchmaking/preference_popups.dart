import 'package:flutter/material.dart';

import '../../models/match_preferences_model.dart';
import '../../theme/app_colors.dart';

class PreferencePopups {
  /// Base visual comum a todos os pop-ups
  static Widget _buildDialogShell({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget content,
    Widget? footer,
  }) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: AppColors.cardBorder, width: 1.2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.accentCyanDark,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon, color: AppColors.accentCyan, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            content,
            if (footer != null) ...[const SizedBox(height: 20), footer],
          ],
        ),
      ),
    );
  }

  /// 1. POP-UP DE DISTÂNCIA (Slider + Presets rápidos)
  static Future<int?> showDistanceDialog(
    BuildContext context, {
    required int currentDistance,
  }) {
    int selectedDistance = currentDistance;
    const presets = [1, 5, 10, 25, 50];

    return showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return _buildDialogShell(
              context: context,
              icon: Icons.location_on_outlined,
              title: 'Search Distance',
              subtitle: 'Maximum radius to find nearby players',
              content: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$selectedDistance Km',
                          style: const TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          'Approximate radius',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primaryPurple,
                      inactiveTrackColor: AppColors.surfaceLight,
                      thumbColor: AppColors.accentCyan,
                      overlayColor: AppColors.accentCyan.withValues(
                        alpha: 0.15,
                      ),
                    ),
                    child: Slider(
                      value: selectedDistance.toDouble(),
                      min: 1,
                      max: 50,
                      divisions: 49,
                      onChanged: (val) {
                        setState(() => selectedDistance = val.round());
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: presets.map((Km) {
                      final isSelected = selectedDistance == Km;
                      return GestureDetector(
                        onTap: () => setState(() => selectedDistance = Km),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryPurple
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryPurple
                                  : AppColors.cardBorder,
                            ),
                          ),
                          child: Text(
                            '${Km}Km',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              footer: SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(selectedDistance),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Apply Distance',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// 2. POP-UP DE START TIME (Seleção direta com 1 toque)
  static Future<StartTimeOption?> showStartTimeDialog(
    BuildContext context, {
    required StartTimeOption currentStartTime,
  }) {
    return showDialog<StartTimeOption>(
      context: context,
      builder: (context) {
        return _buildDialogShell(
          context: context,
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
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.accentCyan,
                            size: 20,
                          )
                        else
                          const Icon(
                            Icons.radio_button_unchecked_rounded,
                            color: AppColors.textMuted,
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
      },
    );
  }

  /// 3. POP-UP DE PLAY STYLE (Cartões descritivos com 1 toque)
  static Future<PlayStyleOption?> showPlayStyleDialog(
    BuildContext context, {
    required PlayStyleOption currentPlayStyle,
  }) {
    return showDialog<PlayStyleOption>(
      context: context,
      builder: (context) {
        return _buildDialogShell(
          context: context,
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
      },
    );
  }
}
