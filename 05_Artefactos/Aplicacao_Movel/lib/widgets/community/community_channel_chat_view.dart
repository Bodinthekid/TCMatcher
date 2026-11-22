import 'package:flutter/material.dart';
import '../../models/store_community_models.dart';
import '../../theme/app_colors.dart';
import '../store/community/store_chat_header.dart';
import '../store/community/store_message_input_bar.dart';
import '../store/community/store_message_tile.dart';
import 'community_channel_search_bar.dart';
import 'community_date_divider.dart';

class CommunityChannelChatView extends StatefulWidget {
  final CommunityChannel channel;
  final int memberCount;
  final List<CommunityMessage> messages;
  final TextEditingController messageController;
  final VoidCallback onBackToChannels;
  final VoidCallback onChannelDetailsTap;
  final VoidCallback onSend;

  const CommunityChannelChatView({
    super.key,
    required this.channel,
    required this.memberCount,
    required this.messages,
    required this.messageController,
    required this.onBackToChannels,
    required this.onChannelDetailsTap,
    required this.onSend,
  });

  @override
  State<CommunityChannelChatView> createState() =>
      _CommunityChannelChatViewState();
}

class _CommunityChannelChatViewState extends State<CommunityChannelChatView> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isSearching = false;

  @override
  void didUpdateWidget(covariant CommunityChannelChatView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.channel.id != widget.channel.id) {
      _isSearching = false;
      _searchCtrl.clear();
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<CommunityMessage> get _visibleMessages {
    final query = _searchCtrl.text.trim().toLowerCase();
    return widget.messages.where((m) {
      if (m.channelId != widget.channel.id) return false;
      if (!_isSearching || query.isEmpty) return true;
      return m.text.toLowerCase().contains(query) ||
          m.author.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _visibleMessages;

    return Column(
      children: [
        StoreChatHeader(
          channel: widget.channel,
          memberCount: widget.memberCount,
          isSearching: _isSearching,
          onBackToChannels: widget.onBackToChannels,
          onChannelDetailsTap: widget.onChannelDetailsTap,
          onToggleSearch: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) _searchCtrl.clear();
            });
          },
        ),
        if (_isSearching)
          CommunityChannelSearchBar(
            controller: _searchCtrl,
            channelName: widget.channel.name,
            onChanged: (_) => setState(() {}),
          ),
        Expanded(
          child: items.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No messages in #${widget.channel.name} yet.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final message = items[index];
                    final showDate = index == 0 ||
                        items[index - 1].dateGroup != message.dateGroup;

                    return Column(
                      children: [
                        if (showDate)
                          CommunityDateDivider(label: message.dateGroup),
                        StoreMessageTile(message: message),
                      ],
                    );
                  },
                ),
        ),
        StoreMessageInputBar(
          controller: widget.messageController,
          currentChannel: widget.channel.name,
          onSend: widget.onSend,
        ),
      ],
    );
  }
}