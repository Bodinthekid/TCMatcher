import '../models/player_community_models.dart';
import '../theme/app_colors.dart';

class PlayerCommunityDmsMock {
  static List<DirectMessageThread> buildDmThreads() {
    return [
      DirectMessageThread(
        id: 'dm_maya',
        playerName: 'Maya Chen',
        username: 'mayacards',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
        statusColor: AppColors.statusAvailable,
        statusLabel: 'Available to Play',
        favoriteGame: 'Pokémon',
        lastTime: '5m',
        unreadCount: 1,
        messages: [
          const DirectMessageItem(
            id: 'd1',
            senderName: 'Maya Chen',
            senderAvatar: 'https://i.pravatar.cc/150?img=47',
            timestamp: 'Today at 7:42 PM',
            dateGroup: 'Today',
            text: 'Hey! Still down for Commander at Mana Vault later?',
          ),
          const DirectMessageItem(
            id: 'd2',
            senderName: 'You',
            senderAvatar: 'https://i.pravatar.cc/150?img=60',
            timestamp: 'Today at 7:45 PM',
            dateGroup: 'Today',
            text: 'For sure, heading there around 8.',
            isMe: true,
          ),
          const DirectMessageItem(
            id: 'd3',
            senderName: 'Maya Chen',
            senderAvatar: 'https://i.pravatar.cc/150?img=47',
            timestamp: 'Today at 7:46 PM',
            dateGroup: 'Today',
            text: 'Nice! I saved a seat at table 4.',
          ),
        ],
      ),
      DirectMessageThread(
        id: 'dm_eli',
        playerName: 'Eli Rivera',
        username: 'elirivera',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        statusColor: AppColors.statusAvailable,
        statusLabel: 'Available to Play',
        favoriteGame: 'Magic',
        lastTime: '1h',
        messages: [
          const DirectMessageItem(
            id: 'd4',
            senderName: 'Eli Rivera',
            senderAvatar: 'https://i.pravatar.cc/150?img=12',
            timestamp: 'Today at 6:15 PM',
            dateGroup: 'Today',
            text: 'GGs earlier! Let me know when you want a rematch.',
          ),
        ],
      ),
      DirectMessageThread(
        id: 'dm_jordan',
        playerName: 'Jordan Brooks',
        username: 'sideboardj',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        statusColor: AppColors.statusOnline,
        statusLabel: 'Online',
        favoriteGame: 'One Piece',
        lastTime: 'Yesterday',
        messages: [
          const DirectMessageItem(
            id: 'd5',
            senderName: 'Jordan Brooks',
            senderAvatar: 'https://i.pravatar.cc/150?img=11',
            timestamp: 'Yesterday at 9:10 PM',
            dateGroup: 'Yesterday',
            text: 'Brought my trade binder if you still need those staples.',
          ),
        ],
      ),
      DirectMessageThread(
        id: 'dm_avery',
        playerName: 'Avery Kim',
        username: 'averykim',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        statusColor: AppColors.statusOnline,
        statusLabel: 'Online',
        favoriteGame: 'Yu-Gi-Oh!',
        lastTime: '2d',
        messages: [
          const DirectMessageItem(
            id: 'd6',
            senderName: 'Avery Kim',
            senderAvatar: 'https://i.pravatar.cc/150?img=33',
            timestamp: '2 days ago',
            dateGroup: 'Earlier',
            text: 'Are you entering Saturday locals at Mercadia?',
          ),
        ],
      ),
      DirectMessageThread(
        id: 'dm_nico',
        playerName: 'Nico Santos',
        username: 'nicosantos',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        statusColor: AppColors.statusOffline,
        statusLabel: 'Offline',
        favoriteGame: 'Pokémon',
        lastTime: '4d',
        messages: [
          const DirectMessageItem(
            id: 'd7',
            senderName: 'Nico Santos',
            senderAvatar: 'https://i.pravatar.cc/150?img=5',
            timestamp: '4 days ago',
            dateGroup: 'Earlier',
            text: 'Thanks for the trade!',
          ),
        ],
      ),
    ];
  }
}