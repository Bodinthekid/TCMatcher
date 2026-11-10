import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/header_icon_button.dart';
import '../common/store_avatar_badge.dart';

class StoreCommunityHeader extends StatelessWidget {
  final String serverName;
  final String membersSubtitle;
  final VoidCallback onMembersTap;

  const StoreCommunityHeader({
    super.key,
    this.serverName = 'Mana Vault Server',
    this.membersSubtitle = '248 members · 34 online',
    required this.onMembersTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          const StoreAvatarBadge(size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serverName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  membersSubtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          HeaderIconButton(
            icon: Icons.people_outline_rounded,
            onTap: onMembersTap,
          ),
        ],
      ),
    );
  }
}