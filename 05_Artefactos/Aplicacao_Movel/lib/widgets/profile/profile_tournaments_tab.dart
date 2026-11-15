import 'package:flutter/material.dart';
import '../../models/player_profile_data.dart';
import '../../theme/app_colors.dart';

class ProfileTournamentsTab
    extends StatelessWidget {
  final PlayerProfileData
      profileData;

  const ProfileTournamentsTab({
    super.key,
    required this.profileData,
  });

  Widget _buildTournament(
    PlayerTournamentData tournament,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color:
              AppColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tournament.color
                  .withValues(
                alpha: 0.12,
              ),
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              Icons
                  .emoji_events_outlined,
              color:
                  tournament.color,
              size: 23,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  tournament.title,
                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '${tournament.game} · ${tournament.date}',
                  style:
                      const TextStyle(
                    color: AppColors
                        .textSecondary,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),

          Text(
            tournament.result,
            style: TextStyle(
              color:
                  tournament.color,
              fontSize: 12,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profileData
        .tournaments.isEmpty) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color:
                AppColors.cardBorder,
          ),
        ),
        child: const Column(
          children: [
            Icon(
              Icons
                  .emoji_events_outlined,
              color:
                  AppColors.textMuted,
              size: 30,
            ),

            SizedBox(height: 8),

            Text(
              'No tournaments played yet',
              style: TextStyle(
                color: AppColors
                    .textSecondary,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
          children: [
            const Text(
              'Tournaments played',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            Text(
              '${profileData.tournaments.length} total',
              style: const TextStyle(
                color: AppColors
                    .textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        ...profileData.tournaments
            .map(
          _buildTournament,
        ),
      ],
    );
  }
}