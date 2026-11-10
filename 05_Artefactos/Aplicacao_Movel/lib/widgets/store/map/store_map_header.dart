import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/header_icon_button.dart';

class StoreMapHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final VoidCallback onNotificationTap;

  const StoreMapHeader({
    super.key,
    this.subtitle = 'PORTLAND · 14 PLAYERS NEARBY',
    this.title = 'Store Map',
    required this.onNotificationTap,
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
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationTap,
        ),
      ],
    );
  }
}