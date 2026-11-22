import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../models/store_community_models.dart';
import '../../screens/store_channel_details_screen.dart';
import 'community_channel_chat_view.dart';
import 'community_dm_chat_view.dart';
import 'player_community_hub_view.dart';

class PlayerCommunityActiveView extends StatelessWidget {
  final List<PlayerStoreCommunity> stores;
  final List<DirectMessageThread> dmThreads;
  final PlayerStoreCommunity? selectedStore;
  final String? selectedStoreId;
  final CommunityChannel? activeChannel;
  final String? activeChannelId;
  final DirectMessageThread? activeDm;
  final TextEditingController messageController;
  final VoidCallback onBackFromDm;
  final VoidCallback onSendDm;
  final VoidCallback onBackFromChannel;
  final VoidCallback onSendChannel;
  final VoidCallback onSelectDms;
  final ValueChanged<PlayerStoreCommunity> onSelectStore;
  final VoidCallback onDiscoverStoresTap;
  final ValueChanged<DirectMessageThread> onThreadTap;
  final ValueChanged<CommunityChannel> onChannelSelected;

  const PlayerCommunityActiveView({
    super.key,
    required this.stores,
    required this.dmThreads,
    required this.selectedStore,
    required this.selectedStoreId,
    required this.activeChannel,
    required this.activeChannelId,
    required this.activeDm,
    required this.messageController,
    required this.onBackFromDm,
    required this.onSendDm,
    required this.onBackFromChannel,
    required this.onSendChannel,
    required this.onSelectDms,
    required this.onSelectStore,
    required this.onDiscoverStoresTap,
    required this.onThreadTap,
    required this.onChannelSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (activeDm != null) {
      return CommunityDmChatView(
        key: ValueKey('dm_${activeDm!.id}'),
        thread: activeDm!,
        messageController: messageController,
        onBack: onBackFromDm,
        onSend: onSendDm,
      );
    }

    if (selectedStore != null && activeChannel != null) {
      return CommunityChannelChatView(
        key: ValueKey('ch_${activeChannel!.id}'),
        channel: activeChannel!,
        memberCount: selectedStore!.memberCount,
        messages: selectedStore!.messages,
        messageController: messageController,
        onBackToChannels: onBackFromChannel,
        onChannelDetailsTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StoreChannelDetailsScreen(
              channel: activeChannel!,
              members: selectedStore!.members,
              messages: selectedStore!.messages
                  .where((m) => m.channelId == activeChannel!.id)
                  .toList(),
            ),
          ),
        ),
        onSend: onSendChannel,
      );
    }

    return PlayerCommunityHubView(
      key: const ValueKey('community_hub'),
      stores: stores,
      dmThreads: dmThreads,
      selectedStore: selectedStore,
      selectedStoreId: selectedStoreId,
      activeChannelId: activeChannelId,
      onSelectDms: onSelectDms,
      onSelectStore: onSelectStore,
      onDiscoverStoresTap: onDiscoverStoresTap,
      onThreadTap: onThreadTap,
      onChannelSelected: onChannelSelected,
    );
  }
}