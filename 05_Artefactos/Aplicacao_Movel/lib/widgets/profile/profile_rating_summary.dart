import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'profile_rating_stars.dart';

class ProfileRatingSummary
    extends StatelessWidget {
  final double rating;
  final int ratingCount;

  const ProfileRatingSummary({
    super.key,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    final roundedRating =
        rating
            .round()
            .clamp(0, 5)
            .toInt();

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color:
              AppColors.cardBorder,
        ),
      ),
      child: Column(
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          ProfileRatingStars(
            rating: roundedRating,
            size: 17,
          ),

          const SizedBox(height: 5),

          Text(
            'Based on $ratingCount player ratings',
            style: const TextStyle(
              color:
                  AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}