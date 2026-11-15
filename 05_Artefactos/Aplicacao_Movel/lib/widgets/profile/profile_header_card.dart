import 'package:flutter/material.dart';
import '../../screens/edit_profile_screen.dart';
import '../../theme/app_colors.dart';
import 'profile_action_buttons.dart';
import 'profile_avatar_status.dart';
import 'profile_favorite_games.dart';
import 'profile_status_sheet.dart';
import 'profile_user_stats.dart';

class ProfileHeaderCard extends StatefulWidget {
  static String savedAvatar =
      'https://i.pravatar.cc/150?img=47';

  static StatusOption savedStatus =
      kStatusOptions[1];

  final String name;
  final String handleAndLocation;
  final String avatarUrl;
  final String statusLabel;
  final Color statusColor;
  final String bio;

  final int followers;
  final int following;

  final bool isEditable;

  const ProfileHeaderCard({
    super.key,
    this.name = 'Maya Chen',
    this.handleAndLocation =
        '@mayacards',
    this.avatarUrl =
        'https://i.pravatar.cc/150?img=47',
    this.statusLabel =
        'Available to Play',
    this.statusColor =
        AppColors.statusAvailable,
    this.bio =
        'Competitive Standard player & casual Commander enthusiast.',
    this.followers = 128,
    this.following = 94,
    this.isEditable = true,
  });

  @override
  State<ProfileHeaderCard>
      createState() =>
          _ProfileHeaderCardState();
}

class _ProfileHeaderCardState
    extends State<ProfileHeaderCard> {
  late String _name;
  late String _handle;
  late String _bio;

  @override
  void initState() {
    super.initState();

    _name = widget.name;

    _handle =
        widget.handleAndLocation
            .split(' · ')
            .first;

    _bio = widget.bio;
  }

  String get _avatar =>
      widget.isEditable
          ? ProfileHeaderCard.savedAvatar
          : widget.avatarUrl;

  String get _statusLabel =>
      widget.isEditable
          ? ProfileHeaderCard
              .savedStatus.label
          : widget.statusLabel;

  Color get _statusColor =>
      widget.isEditable
          ? ProfileHeaderCard
              .savedStatus.color
          : widget.statusColor;

  Color get _statusBackground =>
      widget.isEditable
          ? ProfileHeaderCard
              .savedStatus.bg
          : const Color(0xFF282254);

  void _changeStatus() {
    showProfileStatusSheet(
      context: context,
      currentLabel:
          _statusLabel,
      onSelect: (option) {
        setState(() {
          ProfileHeaderCard
                  .savedStatus =
              option;
        });
      },
    );
  }

  Future<void> _editProfile() async {
    final result =
        await Navigator.push<
            EditProfileResult>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            EditProfileScreen(
          initialName: _name,
          initialUsername:
              _handle.replaceFirst(
            '@',
            '',
          ),
          initialBio: _bio,
          initialAvatarUrl: _avatar,
          initialFavoriteGameIds: {
            ...ProfileFavoriteGames
                .selectedGameIds.value,
          },
        ),
      ),
    );

    if (result == null ||
        !mounted) {
      return;
    }

    ProfileFavoriteGames
        .selectedGameIds.value = {
      ...result.favoriteGameIds,
    };

    setState(() {
      _name = result.name;

      _handle =
          '@${result.username}';

      _bio = result.bio;

      ProfileHeaderCard.savedAvatar =
          result.avatarUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            ProfileAvatarStatus(
              avatarUrl: _avatar,
              statusColor:
                  _statusColor,
              isEditable:
                  widget.isEditable,
              onAvatarTap:
                  _editProfile,
            ),

            const SizedBox(width: 24),

            Expanded(
              child: ProfileUserStats(
                name: _name,
                followers:
                    widget.followers,
                following:
                    widget.following,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        ProfileHandleStatusRow(
          handle: _handle,
          statusLabel:
              _statusLabel,
          statusColor:
              _statusColor,
          statusBackground:
              _statusBackground,
          isEditable:
              widget.isEditable,
          onStatusTap:
              _changeStatus,
        ),

        const SizedBox(height: 8),

        Text(
          _bio,
          style: const TextStyle(
            color:
                AppColors.textSecondary,
            fontSize: 13.5,
            height: 1.35,
          ),
        ),

        const SizedBox(height: 16),

        ProfileActionButtons(
          isEditable:
              widget.isEditable,
          onEditProfile:
              _editProfile,
          onChangeStatus:
              _changeStatus,
          onConnect: () {},
          onMessage: () {},
        ),
      ],
    );
  }
}