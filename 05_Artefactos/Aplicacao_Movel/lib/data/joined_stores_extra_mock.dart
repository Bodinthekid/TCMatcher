import '../models/player_community_models.dart';
import '../models/store_community_models.dart';
import '../theme/app_colors.dart';
import 'store_community_mock_data.dart';

class JoinedStoresExtraMock {
  static List<PlayerStoreCommunity> build() {
    return [
      PlayerStoreCommunity(
        id: 'templars',
        name: 'Templars TCG',
        initials: 'TT',
        accentColor: AppColors.pokemonGold,
        onlineCount: 9,
        memberCount: 84,
        channels: const [
          CommunityChannel(
            id: 'tt_announcements',
            name: 'news-and-drops',
            topic: 'New booster restocks and promos.',
            category: 'INFO',
            isAnnouncement: true,
          ),
          CommunityChannel(
            id: 'tt_general',
            name: 'general-chat',
            topic: 'Community chat and event photos.',
            category: 'TEXT CHANNELS',
          ),
          CommunityChannel(
            id: 'tt_pokemon',
            name: 'pokemon-standard',
            topic: 'Standard league prep and trades.',
            category: 'TCG LOUNGES',
          ),
        ],
        members: List.of(StoreCommunityMockData.members),
        messages: [
          const CommunityMessage(
            id: 'tt_m1',
            channelId: 'tt_general',
            author: 'Maya Chen',
            role: 'MOD',
            timestamp: 'Yesterday at 5:20 PM',
            dateGroup: 'Yesterday',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
            text: 'Who is playing League Cup this Sunday?',
          ),
        ],
      ),
      PlayerStoreCommunity(
        id: 'mercadia',
        name: 'Mercadia Cards',
        initials: 'MC',
        accentColor: AppColors.onePieceBlue,
        onlineCount: 14,
        memberCount: 118,
        channels: const [
          CommunityChannel(
            id: 'mc_general',
            name: 'general',
            topic: 'General TCG discussion and meetups.',
            category: 'TEXT CHANNELS',
          ),
          CommunityChannel(
            id: 'mc_onepiece',
            name: 'one-piece-locals',
            topic: 'One Piece TCG tournaments and decklists.',
            category: 'TCG LOUNGES',
          ),
        ],
        members: List.of(StoreCommunityMockData.members),
        messages: [
          const CommunityMessage(
            id: 'mc_m1',
            channelId: 'mc_onepiece',
            author: 'Avery Kim',
            role: 'PLAYER',
            timestamp: 'Today at 1:05 PM',
            dateGroup: 'Today',
            avatarUrl: 'https://i.pravatar.cc/150?img=33',
            text:
                'Bringing two extra One Piece decks if someone wants to try the game.',
          ),
        ],
      ),
    ];
  }
}