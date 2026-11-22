import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared/app_bottom_nav_bar.dart';
import 'discover_screen.dart';
import 'events_screen.dart';
import 'matchmaking_screen.dart';
import 'player_community_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    DiscoverScreen(),
    MatchmakingScreen(),
    PlayerCommunityScreen(),
    EventsScreen(),
    ProfileScreen(),
  ];

  static const List<AppBottomNavItem> _navItems = [
    AppBottomNavItem(icon: Icons.people_outline, label: 'Discover', iconSize: 22),
    AppBottomNavItem(icon: Icons.bolt, label: 'Matches', iconSize: 22),
    AppBottomNavItem(icon: Icons.forum_outlined, label: 'Community', iconSize: 21),
    AppBottomNavItem(icon: Icons.calendar_today_outlined, label: 'Events', iconSize: 20),
    AppBottomNavItem(icon: Icons.person_outline, label: 'Profile', iconSize: 22),
  ];

  @override
  Widget build(BuildContext context) {
    final safeIndex = _currentIndex.clamp(0, _screens.length - 1);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[safeIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: safeIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
        selectedColor: AppColors.primaryPurple,
        labelFontSize: 10.5,
        selectedFontWeight: FontWeight.w600,
        splashRadius: 26,
      ),
    );
  }
}