import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'preference_dialog_shell.dart';

class DistancePreferenceDialog extends StatefulWidget {
  final int currentDistance;

  const DistancePreferenceDialog({
    super.key,
    required this.currentDistance,
  });

  @override
  State<DistancePreferenceDialog> createState() =>
      _DistancePreferenceDialogState();
}

class _DistancePreferenceDialogState extends State<DistancePreferenceDialog> {
  static const List<int> _presets = [1, 5, 10, 25, 50];
  late int _selectedDistance;

  @override
  void initState() {
    super.initState();
    _selectedDistance = widget.currentDistance;
  }

  @override
  Widget build(BuildContext context) {
    return PreferenceDialogShell(
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
                  '$_selectedDistance Km',
                  style: const TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Approximate radius',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
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
              overlayColor: AppColors.accentCyan.withValues(alpha: 0.15),
            ),
            child: Slider(
              value: _selectedDistance.toDouble(),
              min: 1,
              max: 50,
              divisions: 49,
              onChanged: (val) => setState(() => _selectedDistance = val.round()),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _presets.map((km) {
              final isSelected = _selectedDistance == km;
              return GestureDetector(
                onTap: () => setState(() => _selectedDistance = km),
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
                    '${km}Km',
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
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
          onPressed: () => Navigator.of(context).pop(_selectedDistance),
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
  }
}