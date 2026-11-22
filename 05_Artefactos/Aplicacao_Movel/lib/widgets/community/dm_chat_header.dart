import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../screens/profile_screen.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

class DmChatHeader extends StatelessWidget {
  final DirectMessageThread thread;
  final VoidCallback onBack;

  const DmChatHeader({
    super.key,
    required this.thread,
    required this.onBack,
  });

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          name: thread.playerName,
          handleAndLocation: '@${thread.username}',
          avatarUrl: thread.avatarUrl,
          statusLabel: thread.statusLabel,
          statusColor: thread.statusColor,
          showBackButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _openProfile(context),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  UserAvatar(
                    imageUrl: thread.avatarUrl,
                    size: 36,
                    statusColor: thread.statusColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thread.playerName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '@${thread.username}',
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}