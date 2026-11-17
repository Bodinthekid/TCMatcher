import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ProfileUserStats
    extends StatelessWidget {
  final String name;

  final int followers;
  final int following;

  const ProfileUserStats({
    super.key,
    required this.name,
    required this.followers,
    required this.following,
  });

  Widget _buildStat(
    String value,
    String label,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight:
                FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            _buildStat(
              followers.toString(),
              'followers',
            ),

            Container(
              width: 1,
              height: 30,
              color:
                  AppColors.cardBorder,
            ),

            _buildStat(
              following.toString(),
              'following',
            ),
          ],
        ),
      ],
    );
  }
}