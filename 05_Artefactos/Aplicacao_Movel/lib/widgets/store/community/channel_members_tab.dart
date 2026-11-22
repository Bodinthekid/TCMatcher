import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import 'channel_member_row.dart';

class ChannelMembersTab extends StatelessWidget {
  final List<CommunityMember> members;

  const ChannelMembersTab({
    super.key,
    required this.members,
  });

  Widget _buildSection(String label, List<CommunityMember> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
          child: Text(
            '$label — ${items.length}',
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  ChannelMemberRow(member: items[i]),
                  if (i < items.length - 1)
                    const Divider(color: AppColors.cardBorder, height: 1),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final online = members.where((m) => m.isOnline).toList();
    final offline = members.where((m) => !m.isOnline).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Store invite link copied.')),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.accentCyan,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Invite members',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        _buildSection('Online', online),
        _buildSection('Offline', offline),
      ],
    );
  }
}