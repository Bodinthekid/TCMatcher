import 'package:flutter/material.dart';
import '../data/discoverable_stores_mock.dart';
import '../data/player_community_dms_mock.dart';
import '../data/player_community_stores_mock.dart';
import '../models/player_community_models.dart';
import '../models/store_community_models.dart';
import '../services/auth_services.dart';
import '../theme/app_colors.dart';
import '../utils/community_time_formatter.dart';
import '../widgets/community/community_join_store_sheet.dart';
import '../widgets/community/player_community_active_view.dart';
import '../widgets/profile/profile_header_card.dart';

class PlayerCommunityScreen extends StatefulWidget {
  const PlayerCommunityScreen({super.key});

  @override
  State<PlayerCommunityScreen> createState() => _PlayerCommunityScreenState();
}

class _PlayerCommunityScreenState extends State<PlayerCommunityScreen> {
  final TextEditingController _msgCtrl = TextEditingController();
  late final _stores = PlayerCommunityStoresMock.buildJoinedStores();
  late final _discoverableStores =
      DiscoverableStoresMock.buildDiscoverableStores();
  late final _dmThreads = PlayerCommunityDmsMock.buildDmThreads();

  String? _selectedStoreId;
  String? _activeChannelId;
  String? _activeDmId;

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  String get _userName => AuthService.currentUserName ?? 'You';

  PlayerStoreCommunity? get _selectedStore =>
      _stores.where((s) => s.id == _selectedStoreId).firstOrNull;
  CommunityChannel? get _activeChannel => _selectedStore?.channels
      .where((c) => c.id == _activeChannelId)
      .firstOrNull;
  DirectMessageThread? get _activeDm =>
      _dmThreads.where((t) => t.id == _activeDmId).firstOrNull;

  void _openJoinStoreSheet() {
    final joinedIds = _stores.map((s) => s.id).toSet();
    final available =
        _discoverableStores.where((s) => !joinedIds.contains(s.id)).toList();

    showJoinStoreCommunitySheet(
      context: context,
      availableStores: available,
      onJoinStore: (store) => setState(() {
        _stores.add(store);
        _selectedStoreId = store.id;
        _activeChannelId = null;
        _activeDmId = null;
      }),
    );
  }

  void _sendChannelMessage() {
    final text = _msgCtrl.text.trim();
    final store = _selectedStore;
    final channel = _activeChannel;
    if (text.isEmpty || store == null || channel == null) return;

    setState(() {
      store.messages.add(
        CommunityMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          channelId: channel.id,
          author: _userName,
          role: 'PLAYER',
          timestamp: formatCommunityNow(),
          dateGroup: 'Today',
          avatarUrl: ProfileHeaderCard.savedAvatar,
          text: text,
        ),
      );
      _msgCtrl.clear();
    });
  }

  void _sendDmMessage() {
    final text = _msgCtrl.text.trim();
    final thread = _activeDm;
    if (text.isEmpty || thread == null) return;

    setState(() {
      thread.messages.add(
        DirectMessageItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderName: _userName,
          senderAvatar: ProfileHeaderCard.savedAvatar,
          timestamp: formatCommunityNow(),
          dateGroup: 'Today',
          text: text,
          isMe: true,
        ),
      );
      _msgCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: PlayerCommunityActiveView(
            stores: _stores,
            dmThreads: _dmThreads,
            selectedStore: _selectedStore,
            selectedStoreId: _selectedStoreId,
            activeChannel: _activeChannel,
            activeChannelId: _activeChannelId,
            activeDm: _activeDm,
            messageController: _msgCtrl,
            onBackFromDm: () => setState(() => _activeDmId = null),
            onSendDm: _sendDmMessage,
            onBackFromChannel: () => setState(() => _activeChannelId = null),
            onSendChannel: _sendChannelMessage,
            onSelectDms: () => setState(() {
              _selectedStoreId = null;
              _activeChannelId = null;
            }),
            onSelectStore: (s) => setState(() {
              _selectedStoreId = s.id;
              _activeDmId = null;
            }),
            onDiscoverStoresTap: _openJoinStoreSheet,
            onThreadTap: (t) => setState(() => _activeDmId = t.id),
            onChannelSelected: (c) => setState(() => _activeChannelId = c.id),
          ),
        ),
      ),
    );
  }
}