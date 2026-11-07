import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/store/events/store_events_header.dart';
import '../widgets/store/events/store_events_tabs_bar.dart';
import '../widgets/store/events/store_event_card.dart';

class StoreEventsScreen extends StatefulWidget {
  const StoreEventsScreen({super.key});

  @override
  State<StoreEventsScreen> createState() => _StoreEventsScreenState();
}

class _StoreEventsScreenState extends State<StoreEventsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreEventsHeader(
                onCalendarTap: () {},
              ),
              const SizedBox(height: 20),
              StoreEventsTabsBar(
                selectedTab: _selectedTab,
                onTabChanged: (i) => setState(() => _selectedTab = i),
              ),
              const SizedBox(height: 18),
              const StoreEventCard(
                gameName: 'One Piece',
                gameIcon: Icons.anchor_rounded,
                gameColor: AppColors.onePieceBlue,
                title: 'One Piece Local Championship',
                storeLocation: 'Mana Vault Games · Tables 1–12',
                dateTime: 'Sat, Oct 3 · 2:00 PM',
                spotsInfo: ' · 18/24 spots · €10',
                imageUrl:
                    'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=400&q=80',
              ),
              const SizedBox(height: 14),
              const StoreEventCard(
                gameName: 'Pokémon',
                gameIcon: Icons.catching_pokemon,
                gameColor: AppColors.pokemonGold,
                title: 'Pokémon League Challenge',
                storeLocation: 'Mana Vault Games · Main Hall',
                dateTime: 'Sun, Oct 4 · 11:00 AM',
                spotsInfo: ' · 20/32 spots · €5',
                imageUrl:
                    'https://images.unsplash.com/photo-1606167668584-78701c57f13d?auto=format&fit=crop&w=400&q=80',
              ),
              const SizedBox(height: 14),
              const StoreEventCard(
                gameName: 'Magic',
                gameIcon: Icons.local_fire_department_outlined,
                gameColor: AppColors.magicOrange,
                title: 'Friday Night Commander Pods',
                storeLocation: 'Mana Vault Games · Casual Zone',
                dateTime: 'Fri, Oct 9 · 7:00 PM',
                spotsInfo: ' · 10/16 spots · Free',
                imageUrl:
                    'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=400&q=80',
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}