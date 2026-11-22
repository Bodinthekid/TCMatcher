import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/shared/app_bottom_nav_bar.dart';
import 'store_community_screen.dart';
import 'store_events_screen.dart';
import 'store_profile_screen.dart';

class StoreShellScreen extends StatefulWidget {
  const StoreShellScreen({super.key});

  @override
  State<StoreShellScreen> createState() => _StoreShellScreenState();
}

class _StoreShellScreenState extends State<StoreShellScreen> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    StoreCommunityScreen(),
    StoreEventsScreen(),
    StoreProfileScreen(),
  ];

  static const List<AppBottomNavItem> _navItems = [
    AppBottomNavItem(icon: Icons.forum_outlined, label: 'Community', iconSize: 22),
    AppBottomNavItem(icon: Icons.calendar_today_outlined, label: 'Events', iconSize: 20),
    AppBottomNavItem(icon: Icons.person_outline, label: 'Profile', iconSize: 22),
  ];

  @override
  Widget build(BuildContext context) {
    final safeIndex = _currentIndex.clamp(0, _screens.length - 1);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _screens[safeIndex],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: safeIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
        selectedColor: AppColors.primaryPurple,
        labelFontSize: 11,
        selectedFontWeight: FontWeight.w700,
        splashRadius: 28,
      ),
    );
  }
}