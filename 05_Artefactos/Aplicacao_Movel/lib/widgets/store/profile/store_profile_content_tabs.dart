import 'package:flutter/material.dart';
import '../../../models/store_profile_data.dart';
import '../../../theme/app_colors.dart';
import '../../profile/profile_rating_summary.dart';
import '../../profile/profile_review_card.dart';
import 'store_about_tab.dart';
import 'store_tournaments_tab.dart';

class StoreProfileContentTabs extends StatefulWidget {
  final StoreProfileData storeData;

  const StoreProfileContentTabs({
    super.key,
    required this.storeData,
  });

  @override
  State<StoreProfileContentTabs> createState() =>
      _StoreProfileContentTabsState();
}

class _StoreProfileContentTabsState extends State<StoreProfileContentTabs> {
  int _selectedTab = 0;

  Widget _buildTabIcon(int index, IconData icon) {
    final active = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Colors.white : AppColors.cardBorder,
                width: active ? 2 : 1,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: active ? Colors.white : AppColors.textMuted,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    final reviews = widget.storeData.reviews;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileRatingSummary(
          rating: widget.storeData.rating,
          ratingCount: widget.storeData.ratingCount,
        ),
        const SizedBox(height: 18),
        const Text(
          'Player reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        if (reviews.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              'No store reviews yet',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
              ),
            ),
          )
        else
          ...List.generate(reviews.length, (index) {
            return Column(
              children: [
                ProfileReviewCard(review: reviews[index]),
                if (index < reviews.length - 1)
                  const Divider(color: AppColors.cardBorder, height: 1),
              ],
            );
          }),
      ],
    );
  }

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 1:
        return _buildReviewsTab();
      case 2:
        return StoreAboutTab(storeData: widget.storeData);
      default:
        return StoreTournamentsTab(storeData: widget.storeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTabIcon(0, Icons.emoji_events_outlined),
            _buildTabIcon(1, Icons.star_outline_rounded),
            _buildTabIcon(2, Icons.storefront_outlined),
          ],
        ),
        const SizedBox(height: 14),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: KeyedSubtree(
            key: ValueKey(_selectedTab),
            child: _buildSelectedTab(),
          ),
        ),
      ],
    );
  }
}