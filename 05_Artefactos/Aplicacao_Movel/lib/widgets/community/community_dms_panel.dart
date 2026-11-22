import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../theme/app_colors.dart';
import 'dm_active_card.dart';
import 'dm_thread_tile.dart';

class CommunityDmsPanel extends StatefulWidget {
  final List<DirectMessageThread> threads;
  final ValueChanged<DirectMessageThread> onThreadTap;

  const CommunityDmsPanel({
    super.key,
    required this.threads,
    required this.onThreadTap,
  });

  @override
  State<CommunityDmsPanel> createState() => _CommunityDmsPanelState();
}

class _CommunityDmsPanelState extends State<CommunityDmsPanel> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final activePlayers = widget.threads
        .where((t) => t.statusColor != AppColors.statusOffline)
        .toList();
    final filtered = widget.threads.where((t) {
      if (query.isEmpty) return true;
      return t.playerName.toLowerCase().contains(query) ||
          t.username.toLowerCase().contains(query) ||
          t.lastMessagePreview.toLowerCase().contains(query);
    }).toList();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22)),
        border: Border(
          top: BorderSide(color: AppColors.cardBorder),
          left: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Messages',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search DMs',
                            hintStyle: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13.5,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (activePlayers.isNotEmpty && query.isEmpty) ...[
            SizedBox(
              height: 84,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: activePlayers.length,
                itemBuilder: (_, index) => DmActiveCard(
                  thread: activePlayers[index],
                  onTap: () => widget.onThreadTap(activePlayers[index]),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          const Divider(color: AppColors.cardBorder, height: 1),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text(
                      'No conversations found',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: filtered.length,
                    itemBuilder: (_, index) => DmThreadTile(
                      thread: filtered[index],
                      onTap: () => widget.onThreadTap(filtered[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}