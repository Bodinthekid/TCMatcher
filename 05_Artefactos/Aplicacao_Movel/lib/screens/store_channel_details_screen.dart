import 'package:flutter/material.dart';
import '../models/store_community_models.dart';
import '../theme/app_colors.dart';
import '../widgets/store/community/channel_details_header.dart';
import '../widgets/store/community/channel_links_tab.dart';
import '../widgets/store/community/channel_media_tab.dart';
import '../widgets/store/community/channel_members_tab.dart';
import '../widgets/store/community/channel_pinned_tab.dart';

class StoreChannelDetailsScreen extends StatefulWidget {
  final CommunityChannel channel;
  final List<CommunityMember> members;
  final List<CommunityMessage> messages;

  const StoreChannelDetailsScreen({
    super.key,
    required this.channel,
    required this.members,
    required this.messages,
  });

  @override
  State<StoreChannelDetailsScreen> createState() =>
      _StoreChannelDetailsScreenState();
}

class _StoreChannelDetailsScreenState extends State<StoreChannelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 4, vsync: this);
  bool _isMuted = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isMuted = !_isMuted),
            icon: Icon(
              _isMuted
                  ? Icons.notifications_off_outlined
                  : Icons.notifications_none_rounded,
              color: _isMuted ? AppColors.textMuted : Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChannelDetailsHeader(channel: widget.channel),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primaryPurple,
            indicatorWeight: 2.5,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textMuted,
            dividerColor: AppColors.cardBorder,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            tabs: const [
              Tab(text: 'Members'),
              Tab(text: 'Media'),
              Tab(text: 'Pinned'),
              Tab(text: 'Links'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ChannelMembersTab(members: widget.members),
                ChannelMediaTab(
                  channelName: widget.channel.name,
                  messages: widget.messages,
                ),
                ChannelPinnedTab(messages: widget.messages),
                ChannelLinksTab(
                  channelName: widget.channel.name,
                  messages: widget.messages,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}