import 'package:flutter/material.dart';
import '../../models/player_profile_data.dart';
import '../../theme/app_colors.dart';
import 'profile_rating_summary.dart';
import 'profile_review_card.dart';

class ProfileRatingTab
    extends StatelessWidget {
  final PlayerProfileData
      profileData;

  const ProfileRatingTab({
    super.key,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        ProfileRatingSummary(
          rating:
              profileData.rating,
          ratingCount:
              profileData.ratingCount,
        ),

        const SizedBox(height: 18),

        const Text(
          'Player reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(height: 4),

        if (profileData
            .reviews.isEmpty)
          const Padding(
            padding:
                EdgeInsets.symmetric(
              vertical: 18,
            ),
            child: Text(
              'No player reviews yet',
              style: TextStyle(
                color: AppColors
                    .textSecondary,
                fontSize: 12.5,
              ),
            ),
          )
        else
          ...List.generate(
            profileData
                .reviews.length,
            (index) {
              final review =
                  profileData
                      .reviews[index];

              return Column(
                children: [
                  ProfileReviewCard(
                    review: review,
                  ),

                  if (index <
                      profileData
                              .reviews
                              .length -
                          1)
                    const Divider(
                      color:
                          AppColors.cardBorder,
                      height: 1,
                    ),
                ],
              );
            },
          ),
      ],
    );
  }
}