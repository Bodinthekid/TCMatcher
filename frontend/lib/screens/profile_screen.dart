import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  bool _availableNow = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MATCH LOG',
                          style: TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'This month · 8–3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '73%',
                          style: TextStyle(
                            color: AppColors.winGreen,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'win rate',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.cardBorder, height: 1),
                const MatchLogRow(
                  isWin: true,
                  opponent: 'vs. Eli R.',
                  gameFormat: 'Magic · Commander',
                  score: '2–1',
                  dateLabel: 'Today',
                ),
                const Divider(color: AppColors.cardBorder, height: 1),
                const MatchLogRow(
                  isWin: false,
                  opponent: 'vs. Nico S.',
                  gameFormat: 'Pokémon · Standard',
                  score: '1–2',
                  dateLabel: 'Wed',
                ),
                const Divider(color: AppColors.cardBorder, height: 1),
                const MatchLogRow(
                  isWin: true,
                  opponent: 'vs. Avery K.',
                  gameFormat: 'One Piece · Constructed',
                  score: '2–0',
                  dateLabel: 'Oct 2',
                ),
                const Divider(color: AppColors.cardBorder, height: 1),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sportsmanship',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.star_border_rounded,
                            color: AppColors.pokemonGold,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          UiKitSectionCard(
            title: 'Buttons',
            subtitle: '48 px default height · 38 px compact',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shuffle_rounded, size: 18),
                      label: const Text('Find a match'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon:
                          const Icon(Icons.confirmation_number_outlined, size: 18),
                      label: const Text('Join event'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentCyan,
                        foregroundColor: AppColors.background,
                        minimumSize: const Size(0, 48),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline, size: 17),
                      label: const Text('Message'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 48),
                        side: const BorderSide(color: AppColors.cardBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.accentCyan,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.lock_outline, size: 16),
                      label: const Text('Unavailable'),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: AppColors.surfaceLight,
                        disabledForegroundColor: AppColors.textMuted,
                        minimumSize: const Size(0, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Connect'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 38,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: AppColors.cardBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Details'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: const Icon(
                        Icons.bookmarks_outlined,
                        color: AppColors.accentCyan,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const UiKitSectionCard(
            title: 'Inputs',
            subtitle: 'Visible labels stay persistent for accessibility',
            child: Column(
              children: [
                LabeledInputField(
                  label: 'Search players',
                  hintOrValue: 'Name, game, or city',
                  prefixIcon: Icons.search,
                  isPlaceholder: true,
                ),
                SizedBox(height: 14),
                LabeledInputField(
                  label: 'Focused',
                  hintOrValue: 'Commander',
                  prefixIcon: Icons.search,
                  borderColor: AppColors.primaryPurple,
                  iconColor: AppColors.primaryPurple,
                ),
                SizedBox(height: 14),
                LabeledInputField(
                  label: 'Location',
                  hintOrValue: 'Brooklyn, NY',
                  prefixIcon: Icons.location_on_outlined,
                ),
                SizedBox(height: 14),
                LabeledInputField(
                  label: 'Player tag',
                  hintOrValue: 'Tag not found',
                  prefixIcon: Icons.alternate_email,
                  borderColor: AppColors.errorRed,
                  trailingIcon: Icons.error_outline,
                  trailingColor: AppColors.errorRed,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          UiKitSectionCard(
            title: 'Tabs + filters',
            subtitle: 'Selected states combine color, border, and weight',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TabItem(
                      label: 'Nearby',
                      count: '24',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                    const SizedBox(width: 20),
                    TabItem(
                      label: 'Following',
                      count: '8',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                    const SizedBox(width: 20),
                    TabItem(
                      label: 'New players',
                      isSelected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ],
                ),
                const Divider(color: AppColors.cardBorder, height: 1),
                const SizedBox(height: 16),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    GamePillChip(
                      label: 'Pokémon',
                      icon: Icons.catching_pokemon,
                      color: AppColors.pokemonGold,
                    ),
                    GamePillChip(
                      label: 'Yu-Gi-Oh!',
                      icon: Icons.change_history_rounded,
                      color: AppColors.yugiohPurple,
                    ),
                    GamePillChip(
                      label: 'Magic',
                      icon: Icons.local_fire_department_outlined,
                      color: AppColors.magicOrange,
                    ),
                    GamePillChip(
                      label: 'One Piece',
                      icon: Icons.anchor_rounded,
                      color: AppColors.onePieceBlue,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Only show players ready to meet',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _availableNow,
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.primaryPurple,
                      onChanged: (val) => setState(() => _availableNow = val),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const UiKitSectionCard(
            title: 'Avatars + badges',
            subtitle: 'Presence is never communicated by color alone',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserAvatar(
                      imageUrl: 'https://i.pravatar.cc/150?img=47',
                      size: 54,
                      statusColor: AppColors.statusOnline,
                    ),
                    SizedBox(width: 14),
                    UserAvatar(
                      imageUrl: 'https://i.pravatar.cc/150?img=11',
                      size: 44,
                      statusColor: AppColors.statusAvailable,
                    ),
                    SizedBox(width: 14),
                    UserAvatar(
                      imageUrl: 'https://i.pravatar.cc/150?img=32',
                      size: 36,
                      statusColor: AppColors.statusOffline,
                    ),
                    SizedBox(width: 14),
                    UserAvatar(
                      imageUrl: 'https://i.pravatar.cc/150?img=15',
                      size: 28,
                      statusColor: AppColors.statusOnline,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    StatusBadge(
                      label: 'Online',
                      dotColor: AppColors.statusOnline,
                      backgroundColor: Color(0xFF142928),
                    ),
                    StatusBadge(
                      label: 'Available to Play',
                      dotColor: AppColors.statusAvailable,
                      backgroundColor: Color(0xFF282254),
                    ),
                    StatusBadge(
                      label: 'Offline',
                      dotColor: AppColors.statusOffline,
                      backgroundColor: AppColors.surfaceLight,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    AchievementBadge(
                      icon: Icons.emoji_events_outlined,
                      label: 'Top 8',
                      color: AppColors.pokemonGold,
                      bgColor: Color(0xFF332917),
                    ),
                    AchievementBadge(
                      icon: Icons.verified_user_outlined,
                      label: 'Verified',
                      color: AppColors.accentCyan,
                      bgColor: AppColors.accentCyanDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}