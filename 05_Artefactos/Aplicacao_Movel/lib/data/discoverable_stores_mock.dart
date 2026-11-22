import '../models/player_community_models.dart';
import '../models/store_community_models.dart';
import '../theme/app_colors.dart';
import 'store_community_mock_data.dart';

class DiscoverableStoresMock {
  static List<PlayerStoreCommunity> buildDiscoverableStores() {
    return [
      PlayerStoreCommunity(
        id: 'lotus_cards',
        name: 'Lotus Arena Lisbon',
        initials: 'LA',
        accentColor: AppColors.yugiohPurple,
        onlineCount: 11,
        memberCount: 79,
        channels: const [
          CommunityChannel(
            id: 'la_announcements',
            name: 'announcements',
            topic: 'Weekly store schedules and booster drops.',
            category: 'INFO',
            isAnnouncement: true,
          ),
          CommunityChannel(
            id: 'la_general',
            name: 'general-chat',
            topic: 'Meet local players and organize games.',
            category: 'TEXT CHANNELS',
          ),
        ],
        members: List.of(StoreCommunityMockData.members),
        messages: [
          const CommunityMessage(
            id: 'la_m1',
            channelId: 'la_general',
            author: 'Lotus Arena Lisbon',
            role: 'STORE',
            timestamp: 'Today at 11:30 AM',
            dateGroup: 'Today',
            avatarUrl: 'https://i.pravatar.cc/150?img=68',
            text: 'Welcome to Lotus Arena! Casual tables open all afternoon.',
          ),
        ],
      ),
      PlayerStoreCommunity(
        id: 'porto_deckhouse',
        name: 'DeckHouse Porto',
        initials: 'DH',
        accentColor: AppColors.statusOnline,
        onlineCount: 19,
        memberCount: 134,
        channels: const [
          CommunityChannel(
            id: 'dh_general',
            name: 'general',
            topic: 'Porto TCG community lounge.',
            category: 'TEXT CHANNELS',
          ),
          CommunityChannel(
            id: 'dh_trades',
            name: 'trades',
            topic: 'Swap singles and binders.',
            category: 'TCG LOUNGES',
          ),
        ],
        members: List.of(StoreCommunityMockData.members),
        messages: [
          const CommunityMessage(
            id: 'dh_m1',
            channelId: 'dh_general',
            author: 'DeckHouse Porto',
            role: 'STORE',
            timestamp: 'Today at 2:00 PM',
            dateGroup: 'Today',
            avatarUrl: 'https://i.pravatar.cc/150?img=68',
            text: 'Saturday draft pods are filling up fast!',
          ),
        ],
      ),
    ];
  }
}