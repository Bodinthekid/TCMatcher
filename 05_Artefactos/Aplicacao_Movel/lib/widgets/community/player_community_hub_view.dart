import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../models/store_community_models.dart';
import 'community_dms_panel.dart';
import 'community_server_rail.dart';
import 'community_store_panel.dart';

class PlayerCommunityHubView extends StatelessWidget {
  final List<PlayerStoreCommunity> stores;
  final List<DirectMessageThread> dmThreads;
  final PlayerStoreCommunity? selectedStore;
  final String? selectedStoreId;
  final String? activeChannelId;
  final VoidCallback onSelectDms;
  final ValueChanged<PlayerStoreCommunity> onSelectStore;
  final VoidCallback onDiscoverStoresTap;
  final ValueChanged<DirectMessageThread> onThreadTap;
  final ValueChanged<CommunityChannel> onChannelSelected;

  const PlayerCommunityHubView({
    super.key,
    required this.stores,
    required this.dmThreads,
    required this.selectedStore,
    required this.selectedStoreId,
    required this.activeChannelId,
    required this.onSelectDms,
    required this.onSelectStore,
    required this.onDiscoverStoresTap,
    required this.onThreadTap,
    required this.onChannelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final unreadDms = dmThreads.fold<int>(0, (sum, t) => sum + t.unreadCount);

    return Row(
      children: [
        CommunityServerRail(
          stores: stores,
          selectedStoreId: selectedStoreId,
          unreadDmCount: unreadDms,
          onSelectDms: onSelectDms,
          onSelectStore: onSelectStore,
          onDiscoverStoresTap: onDiscoverStoresTap,
        ),
        Expanded(
          child: selectedStore == null
              ? CommunityDmsPanel(threads: dmThreads, onThreadTap: onThreadTap)
              : CommunityStorePanel(
                  store: selectedStore!,
                  selectedChannelId: activeChannelId,
                  onChannelSelected: onChannelSelected,
                ),
        ),
      ],
    );
  }
}