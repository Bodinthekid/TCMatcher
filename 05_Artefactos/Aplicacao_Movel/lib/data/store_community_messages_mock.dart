import '../models/store_community_models.dart';
import '../theme/app_colors.dart';

class StoreCommunityMessagesMock {
  static final List<CommunityMessage> initialMessages = [
    const CommunityMessage(
      id: 'm1',
      channelId: 'announcements',
      author: 'Mana Vault Official',
      role: 'STORE',
      timestamp: 'Today at 1:40 PM',
      dateGroup: 'Today',
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
      text: 'Fresh stock just hit the shelves and weekend sign-ups are live.',
      isPinned: true,
      embed: CommunityEmbed(
        title: 'Weekend Tournament Schedule',
        description:
            'Doors open 30 minutes early for deck checks and casual warm-up matches.',
        accentColor: AppColors.primaryPurple,
        fields: {
          'Saturday · 2:00 PM': 'One Piece Local Championship (€10)',
          'Sunday · 11:00 AM': 'Pokémon League Challenge (€5)',
        },
        footer: 'Mana Vault Games · Tables 1–16',
      ),
    ),
    const CommunityMessage(
      id: 'm2',
      channelId: 'general-chat',
      author: 'Mana Vault Official',
      role: 'STORE',
      timestamp: 'Today at 2:15 PM',
      dateGroup: 'Today',
      avatarUrl: 'https://i.pravatar.cc/150?img=68',
      text:
          'New One Piece Booster Boxes just landed! Tables 1–8 are open for Commander at 6 PM.',
      isPinned: true,
      imageUrl:
          'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=700&q=80',
    ),
    const CommunityMessage(
      id: 'm3',
      channelId: 'general-chat',
      author: 'Maya Chen',
      role: 'MOD',
      timestamp: 'Today at 2:24 PM',
      dateGroup: 'Today',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      text:
          'Awesome! Bringing two Commander decks tonight if anyone wants to form a pod.',
      linkUrl: 'https://tcmatcher.app/events/friday-commander',
    ),
    const CommunityMessage(
      id: 'm4',
      channelId: 'general-chat',
      author: 'Jordan Brooks',
      role: 'PLAYER',
      timestamp: 'Today at 2:31 PM',
      dateGroup: 'Today',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      text: 'Count me in! Also brought my trade binder for alt-art leaders.',
      imageUrl:
          'https://images.unsplash.com/photo-1606167668584-78701c57f13d?auto=format&fit=crop&w=700&q=80',
    ),
    const CommunityMessage(
      id: 'm5',
      channelId: 'lfg-commander',
      author: 'Eli Rivera',
      role: 'PLAYER',
      timestamp: 'Today at 4:05 PM',
      dateGroup: 'Today',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      text: 'Looking for 2 more for a Bracket 3 Commander pod around 6:30 PM.',
    ),
    const CommunityMessage(
      id: 'm6',
      channelId: 'pokemon-league',
      author: 'Maya Chen',
      role: 'MOD',
      timestamp: 'Yesterday at 6:12 PM',
      dateGroup: 'Yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      text: 'Anyone testing Standard lists before Sunday League Challenge?',
    ),
    const CommunityMessage(
      id: 'm7',
      channelId: 'card-trades',
      author: 'Jordan Brooks',
      role: 'PLAYER',
      timestamp: 'Yesterday at 8:02 PM',
      dateGroup: 'Yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      text: 'Looking for full-art staples — will be at the store all Saturday.',
    ),
  ];
}