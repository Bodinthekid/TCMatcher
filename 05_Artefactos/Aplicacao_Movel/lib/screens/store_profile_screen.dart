import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared/status_badge.dart';
import '../widgets/store/profile/store_banner_header.dart';
import '../widgets/store/profile/store_profile_header_info.dart';
import '../widgets/store/profile/store_profile_status_section.dart';
import '../widgets/store/profile/store_profile_tabs.dart';
import '../widgets/store/profile/store_tournament_tile.dart';

class StoreProfileScreen extends StatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  int _tab = 0;
  final List<String> _tabs = ['Upcoming Tournaments', 'About', 'Reviews'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StoreBannerHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StoreProfileHeaderInfo(), // 👈 Nome correto alinhado com o ficheiro
                    const StoreProfileStatusSection(),
                    const SizedBox(height: 16),
                    StoreProfileTabs(
                      tabs: _tabs,
                      selectedIndex: _tab,
                      onTabSelected: (i) => setState(() => _tab = i),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Next at Mana Vault',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        StatusBadge(
                          label: '6 scheduled',
                          dotColor: AppColors.winGreen,
                          backgroundColor: AppColors.winGreenBg,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const StoreTournamentTile(
                      code: 'OP',
                      color: AppColors.yugiohPurple,
                      title: 'One Piece Local\nTournament',
                      date: 'Sat, Oct 3 · 2:00 PM',
                      fee: '\$10',
                    ),
                    const SizedBox(height: 10),
                    const StoreTournamentTile(
                      code: 'PK',
                      color: AppColors.accentCyan,
                      title: 'Pokémon League Challenge',
                      date: 'Sun, Oct 4 · 11:00 AM',
                      fee: '\$5',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}