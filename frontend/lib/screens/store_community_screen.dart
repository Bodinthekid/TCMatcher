import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/store/community/store_community_header.dart';
import '../widgets/store/community/store_channel_selector.dart';
import '../widgets/store/community/store_message_tile.dart';
import '../widgets/store/community/store_message_input_bar.dart';

class StoreCommunityScreen extends StatefulWidget {
  const StoreCommunityScreen({super.key});

  @override
  State<StoreCommunityScreen> createState() => _StoreCommunityScreenState();
}

class _StoreCommunityScreenState extends State<StoreCommunityScreen> {
  int _channel = 1;
  final TextEditingController _msgCtrl = TextEditingController();

  final _channels = [
    'announcements',
    'general-chat',
    'lfg-commander',
    'pokemon-league',
    'card-trades',
  ];

  final _messages = [
    {
      'user': 'Mana Vault Official',
      'role': 'STORE',
      'time': '2:15 PM',
      'avatar': 'https://i.pravatar.cc/150?img=68',
      'text': 'New One Piece Booster Boxes just landed! Tables 1-8 are open for Commander at 6 PM.',
    },
    {
      'user': 'Maya Chen',
      'role': 'MOD',
      'time': '2:24 PM',
      'avatar': 'https://i.pravatar.cc/150?img=47',
      'text': 'Awesome! Bringing two Commander decks tonight if anyone wants to form a pod.',
    },
    {
      'user': 'Jordan Brooks',
      'role': 'PLAYER',
      'time': '2:31 PM',
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'text': 'Count me in! Also brought my trade binder for alt-art leaders.',
    },
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _channels[_channel];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            StoreCommunityHeader(
              onMembersTap: () {},
            ),
            StoreChannelSelector(
              channels: _channels,
              selectedIndex: _channel,
              onChannelSelected: (i) => setState(() => _channel = i),
            ),
            const Divider(color: AppColors.cardBorder, height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final m = _messages[i];
                  return StoreMessageTile(
                    user: m['user']!,
                    role: m['role']!,
                    time: m['time']!,
                    avatarUrl: m['avatar']!,
                    text: m['text']!,
                  );
                },
              ),
            ),
            StoreMessageInputBar(
              controller: _msgCtrl,
              currentChannel: current,
              onSend: () {},
            ),
          ],
        ),
      ),
    );
  }
}