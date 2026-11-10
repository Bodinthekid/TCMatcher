import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'game_pill_chip.dart';

class DetailedStoreEventCard extends StatelessWidget {
  final String gameName;
  final IconData gameIcon;
  final Color gameColor;
  final String title;
  final String storeLocation;
  final String dateTime;
  final String spotsInfo;
  final String imageUrl;

  const DetailedStoreEventCard({
    super.key,
    required this.gameName,
    required this.gameIcon,
    required this.gameColor,
    required this.title,
    required this.storeLocation,
    required this.dateTime,
    required this.spotsInfo,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 120,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceLight,
                  child: const Icon(
                    Icons.event,
                    color: AppColors.textMuted,
                    size: 36,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GamePillChip(
                      label: gameName,
                      icon: gameIcon,
                      color: gameColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      storeLocation,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.accentCyan,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              dateTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            spotsInfo,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}