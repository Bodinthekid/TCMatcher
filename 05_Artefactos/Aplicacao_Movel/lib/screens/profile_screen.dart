import 'package:flutter/material.dart';
import '../data/mock_player_profiles.dart';
import '../services/auth_services.dart';
import '../theme/app_colors.dart';
import '../widgets/profile/profile_favorite_games.dart';
import '../widgets/profile/profile_header_card.dart';
import '../widgets/profile/profile_match_log_card.dart';
import '../widgets/profile/profile_menu_drawer.dart';

class ProfileScreen extends StatelessWidget {
  final String? name;
  final String? handleAndLocation;
  final String avatarUrl;
  final String statusLabel;
  final Color statusColor;
  final String bio;
  final bool showBackButton;

  const ProfileScreen({
    super.key,
    this.name,
    this.handleAndLocation,
    this.avatarUrl = 'https://i.pravatar.cc/150?img=47',
    this.statusLabel = 'Available to Play',
    this.statusColor = AppColors.statusAvailable,
    this.bio =
        'Competitive Standard player & casual Commander enthusiast. Always down for local matches!',
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final mockProfile = showBackButton ? MockPlayerProfiles.byName(name) : null;
    final displayName =
        mockProfile?.name ?? name ?? AuthService.currentUserName ?? 'Player';
    final cleanHandle = displayName.toLowerCase().replaceAll(' ', '');
    final displayHandle = mockProfile != null
        ? '@${mockProfile.username}'
        : handleAndLocation ?? '@$cleanHandle';
    final profileData = mockProfile ?? MockPlayerProfiles.currentUserFallback;

    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: showBackButton ? null : const ProfileMenuDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: showBackButton,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (!showBackButton)
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () => Scaffold.of(ctx).openEndDrawer(),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeaderCard(
                name: displayName,
                handleAndLocation: displayHandle,
                avatarUrl: mockProfile?.avatarUrl ?? avatarUrl,
                statusLabel: mockProfile?.statusLabel ?? statusLabel,
                statusColor: mockProfile?.statusColor ?? statusColor,
                bio: mockProfile?.bio ?? bio,
                followers: profileData.followers,
                following: profileData.following,
                isEditable: !showBackButton,
              ),
              const SizedBox(height: 22),
              ProfileFavoriteGames(
                isEditable: !showBackButton,
                gameIds: mockProfile?.favoriteGameIds,
              ),
              const SizedBox(height: 20),
              ProfileMatchLogCard(profileData: profileData),
            ],
          ),
        ),
      ),
    );
  }
}