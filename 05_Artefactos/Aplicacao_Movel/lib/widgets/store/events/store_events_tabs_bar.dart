import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/tab_item.dart';

class StoreEventsTabsBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const StoreEventsTabsBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TabItem(
              label: 'Upcoming',
              count: '3',
              isSelected: selectedTab == 0,
              onTap: () => onTabChanged(0),
            ),
            const SizedBox(width: 20),
            TabItem(
              label: 'Past Events',
              count: '12',
              isSelected: selectedTab == 1,
              onTap: () => onTabChanged(1),
            ),
            const SizedBox(width: 20),
            TabItem(
              label: 'Drafts',
              isSelected: selectedTab == 2,
              onTap: () => onTabChanged(2),
            ),
          ],
        ),
        const Divider(color: AppColors.cardBorder, height: 1),
      ],
    );
  }
}