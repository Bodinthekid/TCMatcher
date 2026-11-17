import 'package:flutter/material.dart';
import '../../models/player_profile_data.dart';
import '../../theme/app_colors.dart';
import 'profile_match_history_tab.dart';
import 'profile_rating_tab.dart';
import 'profile_tournaments_tab.dart';

class ProfileMatchLogCard
    extends StatefulWidget {
  final PlayerProfileData
      profileData;

  const ProfileMatchLogCard({
    super.key,
    required this.profileData,
  });

  @override
  State<ProfileMatchLogCard>
      createState() =>
          _ProfileMatchLogCardState();
}

class _ProfileMatchLogCardState
    extends State<ProfileMatchLogCard> {
  int _selectedTab = 0;

  Widget _buildTabIcon(
    int index,
    IconData icon,
  ) {
    final active =
        _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        behavior:
            HitTestBehavior.opaque,
        child: Container(
          padding:
              const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active
                    ? Colors.white
                    : AppColors.cardBorder,
                width:
                    active ? 2 : 1,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: active
                ? Colors.white
                : AppColors.textMuted,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 1:
        return ProfileRatingTab(
          profileData:
              widget.profileData,
        );

      case 2:
        return ProfileTournamentsTab(
          profileData:
              widget.profileData,
        );

      default:
        return ProfileMatchHistoryTab(
          profileData:
              widget.profileData,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTabIcon(
              0,
              Icons.bolt_rounded,
            ),

            _buildTabIcon(
              1,
              Icons.star_outline_rounded,
            ),

            _buildTabIcon(
              2,
              Icons
                  .emoji_events_outlined,
            ),
          ],
        ),

        const SizedBox(height: 14),

        AnimatedSwitcher(
          duration:
              const Duration(
            milliseconds: 180,
          ),
          child: KeyedSubtree(
            key:
                ValueKey(_selectedTab),
            child:
                _buildSelectedTab(),
          ),
        ),
      ],
    );
  }
}