import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'store_map_screen.dart';
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

  final List<Widget> _screens = const [
    StoreMapScreen(),
    StoreCommunityScreen(),
    StoreEventsScreen(),
    StoreProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(
              color: AppColors.cardBorder,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.map_outlined, size: 22),
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.forum_outlined, size: 22),
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.calendar_today_outlined, size: 20),
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person_outline, size: 22),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}