import 'package:flutter/material.dart';
import '../data/store_community_messages_mock.dart';
import '../data/store_community_mock_data.dart';
import '../models/store_community_models.dart';
import '../services/auth_services.dart';
import '../theme/app_colors.dart';
import '../widgets/community/community_channel_chat_view.dart';
import '../widgets/store/community/create_channel_dialog.dart';
import '../widgets/store/community/store_channels_view.dart';
import 'store_channel_details_screen.dart';

class StoreCommunityScreen extends StatefulWidget {
  const StoreCommunityScreen({super.key});

  @override
  State<StoreCommunityScreen> createState() => _StoreCommunityScreenState();
}

class _StoreCommunityScreenState extends State<StoreCommunityScreen> {
  final TextEditingController _msgCtrl = TextEditingController();

  late List<CommunityChannel> _channels;
  late List<CommunityMessage> _messages;
  late String _selectedChannelId;
  bool _showingChannelsList = false;

  @override
  void initState() {
    super.initState();
    _channels = List.of(StoreCommunityMockData.channels);
    _messages = List.of(StoreCommunityMessagesMock.initialMessages);
    _selectedChannelId = _channels[1].id;
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  String get _storeName {
    final name = AuthService.currentUserName;
    if (name != null && name.trim().isNotEmpty) return name;
    return 'Mana Vault Games';
  }

  CommunityChannel get _activeChannel => _channels.firstWhere(
        (c) => c.id == _selectedChannelId,
        orElse: () => _channels.first,
      );

  void _selectChannel(CommunityChannel channel) {
    setState(() {
      _selectedChannelId = channel.id;
      _showingChannelsList = false;
    });
  }

  void _sendMessage() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    setState(() {
      _messages.add(
        CommunityMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          channelId: _selectedChannelId,
          author: _storeName,
          role: 'STORE',
          timestamp: 'Today at $hour:$minute $period',
          dateGroup: 'Today',
          avatarUrl: 'https://i.pravatar.cc/150?img=68',
          text: text,
        ),
      );
      _msgCtrl.clear();
    });
  }

  Future<void> _openCreateChannel() async {
    final created = await showCreateChannelDialog(context);
    if (created != null && mounted) {
      setState(() {
        _channels.add(created);
        _selectedChannelId = created.id;
        _showingChannelsList = false;
      });
    }
  }

  void _openChannelDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoreChannelDetailsScreen(
          channel: _activeChannel,
          members: StoreCommunityMockData.members,
          messages: _messages
              .where((m) => m.channelId == _selectedChannelId)
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onlineCount =
        StoreCommunityMockData.members.where((m) => m.isOnline).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: _showingChannelsList
            ? StoreChannelsView(
                key: const ValueKey('channels'),
                storeName: _storeName,
                channels: _channels,
                selectedChannelId: _selectedChannelId,
                onlineCount: onlineCount,
                totalMembers: StoreCommunityMockData.members.length,
                onChannelSelected: _selectChannel,
                onAddChannelTap: _openCreateChannel,
              )
            : CommunityChannelChatView(
                key: ValueKey('chat_$_selectedChannelId'),
                channel: _activeChannel,
                memberCount: StoreCommunityMockData.members.length,
                messages: _messages,
                messageController: _msgCtrl,
                onBackToChannels: () =>
                    setState(() => _showingChannelsList = true),
                onChannelDetailsTap: _openChannelDetails,
                onSend: _sendMessage,
              ),
      ),
    );
  }
}