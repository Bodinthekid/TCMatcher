import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/header_icon_button.dart';

class StoreEventsHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final VoidCallback onCalendarTap;

  const StoreEventsHeader({
    super.key,
    this.subtitle = 'MANA VAULT GAMES · 3 SCHEDULED',
    this.title = 'Store Events',
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.accentCyan,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        HeaderIconButton(
          icon: Icons.calendar_month_outlined,
          onTap: onCalendarTap,
        ),
      ],
    );
  }
}