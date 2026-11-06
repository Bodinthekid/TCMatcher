import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DiscoverFeaturedEventCard extends StatelessWidget {
  final String tag;
  final String title;
  final String storeDetails;
  final String seatsLeft;
  final String imageUrl;

  const DiscoverFeaturedEventCard({
    super.key,
    required this.tag,
    required this.title,
    required this.storeDetails,
    required this.seatsLeft,
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
              width: 125,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceLight,
                  child: const Icon(
                    Icons.storefront,
                    color: AppColors.textMuted,
                    size: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tag,
                      style: const TextStyle(
                        color: AppColors.magicOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      storeDetails,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      seatsLeft,
                      style: const TextStyle(
                        color: AppColors.statusOnline,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
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