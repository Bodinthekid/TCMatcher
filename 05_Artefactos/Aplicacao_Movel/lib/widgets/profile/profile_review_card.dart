import 'package:flutter/material.dart';
import '../../data/mock_player_profiles.dart';
import '../../models/player_profile_data.dart';
import '../../screens/profile_screen.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';
import 'profile_rating_stars.dart';

class ProfileReviewCard extends StatelessWidget {
  final PlayerReviewData review;

  const ProfileReviewCard({
    super.key,
    required this.review,
  });

  void _openProfile(BuildContext context, PlayerProfileData player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          name: player.name,
          handleAndLocation: '@${player.username}',
          avatarUrl: player.avatarUrl,
          statusLabel: player.statusLabel,
          statusColor: player.statusColor,
          bio: player.bio,
          showBackButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewer = MockPlayerProfiles.byKey(review.reviewerKey);
    if (reviewer == null) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openProfile(context, reviewer),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                imageUrl: reviewer.avatarUrl,
                size: 42,
                statusColor: reviewer.statusColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reviewer.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '@${reviewer.username}',
                                style: const TextStyle(
                                  color: AppColors.accentCyan,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ProfileRatingStars(rating: review.rating),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      review.review,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View profile',
                          style: TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.accentCyan,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}