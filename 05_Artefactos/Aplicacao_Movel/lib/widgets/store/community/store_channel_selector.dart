import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreChannelSelector extends StatelessWidget {
  final List<String> channels;
  final int selectedIndex;
  final ValueChanged<int> onChannelSelected;

  const StoreChannelSelector({
    super.key,
    required this.channels,
    required this.selectedIndex,
    required this.onChannelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: channels.length,
        itemBuilder: (_, i) {
          final active = selectedIndex == i;
          return GestureDetector(
            onTap: () => onChannelSelected(i),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: active ? AppColors.primaryPurple : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: active ? AppColors.primaryPurple : AppColors.cardBorder,
                ),
              ),
              child: Text(
                '# ${channels[i]}',
                style: TextStyle(
                  color: active ? Colors.white : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}