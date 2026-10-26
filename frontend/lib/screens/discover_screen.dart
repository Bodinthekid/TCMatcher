import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedGameFilter = 4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BROOKLYN · 3 PLAYERS NEARBY',
                    style: TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Discover',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              HeaderIconButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Players, games, or stores',
                      hintStyle: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                Icon(Icons.tune_rounded, color: AppColors.accentCyan, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircularGameIcon(
                icon: Icons.catching_pokemon,
                color: AppColors.pokemonGold,
                isSelected: _selectedGameFilter == 0,
                onTap: () => setState(() => _selectedGameFilter = 0),
              ),
              const SizedBox(width: 10),
              CircularGameIcon(
                icon: Icons.change_history_rounded,
                color: AppColors.yugiohPurple,
                isSelected: _selectedGameFilter == 1,
                onTap: () => setState(() => _selectedGameFilter = 1),
              ),
              const SizedBox(width: 10),
              CircularGameIcon(
                icon: Icons.local_fire_department_outlined,
                color: AppColors.magicOrange,
                isSelected: _selectedGameFilter == 2,
                onTap: () => setState(() => _selectedGameFilter = 2),
              ),
              const SizedBox(width: 10),
              CircularGameIcon(
                icon: Icons.anchor_rounded,
                color: AppColors.onePieceBlue,
                isSelected: _selectedGameFilter == 3,
                onTap: () => setState(() => _selectedGameFilter = 3),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => setState(() => _selectedGameFilter = 4),
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedGameFilter == 4
                        ? AppColors.primaryPurple
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _selectedGameFilter == 4
                          ? AppColors.primaryPurple
                          : AppColors.cardBorder,
                    ),
                  ),
                  child: const Text(
                    'All',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ready nearby',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const CompactPlayerCard(
            name: 'Maya Chen',
            subtitle: '0.8 mi · Competitive',
            avatarUrl: 'https://i.pravatar.cc/150?img=47',
            statusColor: AppColors.statusAvailable,
            gameIcon: Icons.catching_pokemon,
            gameColor: AppColors.pokemonGold,
            isHighlighted: true,
          ),
          const SizedBox(height: 12),
          const CompactPlayerCard(
            name: 'Jordan Brooks',
            subtitle: '2.1 mi · Casual',
            avatarUrl: 'https://i.pravatar.cc/150?img=11',
            statusColor: AppColors.statusOnline,
            gameIcon: Icons.anchor_rounded,
            gameColor: AppColors.onePieceBlue,
            isHighlighted: false,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.cardBorder),
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 125,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=400&q=80',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.surfaceLight,
                        child: const Icon(
                          Icons.storefront,
                          color: AppColors.textMuted,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MAGIC · TODAY',
                            style: TextStyle(
                              color: AppColors.magicOrange,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Friday\nNight\nCommander',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Twenty Sided\nStore · 7 PM',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '6 seats left',
                            style: TextStyle(
                              color: AppColors.statusOnline,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}