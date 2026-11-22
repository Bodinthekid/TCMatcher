import '../models/store_community_models.dart';
import '../theme/app_colors.dart';

class StoreCommunityMockData {
  static const List<CommunityChannel> channels = [
    CommunityChannel(
      id: 'announcements',
      name: 'announcements',
      topic: 'Official store drops, restocks, and tournament alerts.',
      category: 'INFO',
      isAnnouncement: true,
    ),
    CommunityChannel(
      id: 'general-chat',
      name: 'general-chat',
      topic: 'Hang out with local players and talk TCGs.',
      category: 'TEXT CHANNELS',
    ),
    CommunityChannel(
      id: 'lfg-commander',
      name: 'lfg-commander',
      topic: 'Organize Commander pods and casual Magic tables.',
      category: 'TCG LOUNGES',
      unreadCount: 2,
    ),
    CommunityChannel(
      id: 'pokemon-league',
      name: 'pokemon-league',
      topic: 'Deck lists, league cup prep, and Standard testing.',
      category: 'TCG LOUNGES',
    ),
    CommunityChannel(
      id: 'card-trades',
      name: 'card-trades',
      topic: 'Post binders, wants, and arrange in-store trades.',
      category: 'TCG LOUNGES',
    ),
  ];

  static const List<CommunityMember> members = [
    CommunityMember(
      name: 'Mana Vault Official',
      role: 'STORE',
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
      statusColor: AppColors.statusOnline,
      isOnline: true,
    ),
    CommunityMember(
      name: 'Maya Chen',
      role: 'MOD',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      statusColor: AppColors.statusAvailable,
      isOnline: true,
    ),
    CommunityMember(
      name: 'Jordan Brooks',
      role: 'PLAYER',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      statusColor: AppColors.statusOnline,
      isOnline: true,
    ),
    CommunityMember(
      name: 'Eli Rivera',
      role: 'PLAYER',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      statusColor: AppColors.statusAvailable,
      isOnline: true,
    ),
    CommunityMember(
      name: 'Nico Santos',
      role: 'PLAYER',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      statusColor: AppColors.statusOffline,
      isOnline: false,
    ),
    CommunityMember(
      name: 'Avery Kim',
      role: 'PLAYER',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      statusColor: AppColors.statusOffline,
      isOnline: false,
    ),
  ];
}