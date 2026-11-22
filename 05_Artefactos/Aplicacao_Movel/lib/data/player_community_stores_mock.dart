import '../models/player_community_models.dart';
import '../models/store_community_models.dart';
import '../theme/app_colors.dart';
import 'joined_stores_extra_mock.dart';
import 'store_community_messages_mock.dart';
import 'store_community_mock_data.dart';

class PlayerCommunityStoresMock {
  static List<PlayerStoreCommunity> buildJoinedStores() {
    return [
      PlayerStoreCommunity(
        id: 'mana_vault',
        name: 'Mana Vault Games',
        initials: 'MV',
        iconUrl: 'https://i.pravatar.cc/150?img=68',
        accentColor: AppColors.primaryPurple,
        onlineCount: 18,
        memberCount: 142,
        unreadCount: 2,
        channels: List.of(StoreCommunityMockData.channels),
        members: List.of(StoreCommunityMockData.members),
        messages: List.of(StoreCommunityMessagesMock.initialMessages),
      ),
      PlayerStoreCommunity(
        id: 'versus_gc',
        name: 'Versus Gamecenter',
        initials: 'VG',
        accentColor: AppColors.magicOrange,
        onlineCount: 27,
        memberCount: 215,
        unreadCount: 1,
        channels: const [
          CommunityChannel(
            id: 'vg_announcements',
            name: 'announcements',
            topic: 'Official tournament dates and prerelease sign-ups.',
            category: 'INFO',
            isAnnouncement: true,
          ),
          CommunityChannel(
            id: 'vg_general',
            name: 'general',
            topic: 'Main lounge for Lisboa players.',
            category: 'TEXT CHANNELS',
            unreadCount: 1,
          ),
          CommunityChannel(
            id: 'vg_commander',
            name: 'commander-pods',
            topic: 'Find casual and high-power Commander tables.',
            category: 'TCG LOUNGES',
          ),
          CommunityChannel(
            id: 'vg_yugioh',
            name: 'yugioh-locals',
            topic: 'Weekly Yu-Gi-Oh! pairings and deck talk.',
            category: 'TCG LOUNGES',
          ),
        ],
        members: List.of(StoreCommunityMockData.members),
        messages: [
          const CommunityMessage(
            id: 'vg_m1',
            channelId: 'vg_announcements',
            author: 'Versus Staff',
            role: 'STORE',
            timestamp: 'Today at 12:10 PM',
            dateGroup: 'Today',
            avatarUrl: 'https://i.pravatar.cc/150?img=52',
            text: 'Friday Commander night starts at 7:00 PM. Walk-ins welcome!',
            isPinned: true,
          ),
          const CommunityMessage(
            id: 'vg_m2',
            channelId: 'vg_general',
            author: 'Eli Rivera',
            role: 'PLAYER',
            timestamp: 'Today at 3:45 PM',
            dateGroup: 'Today',
            avatarUrl: 'https://i.pravatar.cc/150?img=12',
            text: 'Anyone around for some Modern testing before tonight?',
          ),
        ],
      ),
      ...JoinedStoresExtraMock.build(),
    ];
  }
}