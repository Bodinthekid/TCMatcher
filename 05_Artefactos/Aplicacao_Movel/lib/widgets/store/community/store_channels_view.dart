import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import '../../community/community_channel_tile.dart';
import 'store_channels_header.dart';

class StoreChannelsView extends StatefulWidget {
  final String storeName;
  final List<CommunityChannel> channels;
  final String selectedChannelId;
  final int onlineCount;
  final int totalMembers;
  final ValueChanged<CommunityChannel> onChannelSelected;
  final VoidCallback onAddChannelTap;

  const StoreChannelsView({
    super.key,
    required this.storeName,
    required this.channels,
    required this.selectedChannelId,
    required this.onlineCount,
    required this.totalMembers,
    required this.onChannelSelected,
    required this.onAddChannelTap,
  });

  @override
  State<StoreChannelsView> createState() => _StoreChannelsViewState();
}

class _StoreChannelsViewState extends State<StoreChannelsView> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _collapsedCategories = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = widget.channels.where((c) {
      if (query.isEmpty) return true;
      return c.name.toLowerCase().contains(query) ||
          c.topic.toLowerCase().contains(query);
    }).toList();

    final Map<String, List<CommunityChannel>> grouped = {};
    for (final channel in filtered) {
      grouped.putIfAbsent(channel.category, () => []).add(channel);
    }

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoreChannelsHeader(
            storeName: widget.storeName,
            onlineCount: widget.onlineCount,
            totalMembers: widget.totalMembers,
            searchController: _searchController,
            onSearchChanged: (_) => setState(() {}),
            onAddChannelTap: widget.onAddChannelTap,
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: grouped.entries.map((entry) {
                final category = entry.key;
                final collapsed = _collapsedCategories.contains(category);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          collapsed
                              ? _collapsedCategories.remove(category)
                              : _collapsedCategories.add(category);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 18, 6),
                        child: Row(
                          children: [
                            Icon(
                              collapsed
                                  ? Icons.keyboard_arrow_right_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: AppColors.textMuted,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              category,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!collapsed)
                      ...entry.value.map(
                        (c) => CommunityChannelTile(
                          channel: c,
                          isSelected: c.id == widget.selectedChannelId,
                          onTap: () => widget.onChannelSelected(c),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}