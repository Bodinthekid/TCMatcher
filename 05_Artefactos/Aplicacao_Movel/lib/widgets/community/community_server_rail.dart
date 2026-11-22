import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../theme/app_colors.dart';
import 'rail_item_button.dart';

class CommunityServerRail extends StatelessWidget {
  final List<PlayerStoreCommunity> stores;
  final String? selectedStoreId;
  final int unreadDmCount;
  final VoidCallback onSelectDms;
  final ValueChanged<PlayerStoreCommunity> onSelectStore;
  final VoidCallback onDiscoverStoresTap;

  const CommunityServerRail({
    super.key,
    required this.stores,
    required this.selectedStoreId,
    required this.unreadDmCount,
    required this.onSelectDms,
    required this.onSelectStore,
    required this.onDiscoverStoresTap,
  });

  Widget _buildStoreIcon(PlayerStoreCommunity store, bool isSelected) {
    if (store.iconUrl != null) {
      return Image.network(
        store.iconUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildInitialsBox(store, isSelected),
      );
    }
    return _buildInitialsBox(store, isSelected);
  }

  Widget _buildInitialsBox(PlayerStoreCommunity store, bool isSelected) {
    return Container(
      color: isSelected
          ? store.accentColor
          : store.accentColor.withValues(alpha: 0.22),
      alignment: Alignment.center,
      child: Text(
        store.initials,
        style: TextStyle(
          color: isSelected ? Colors.white : store.accentColor,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDmsSelected = selectedStoreId == null;

    return Container(
      width: 68,
      color: AppColors.background,
      child: Column(
        children: [
          const SizedBox(height: 10),
          RailItemButton(
            isSelected: isDmsSelected,
            hasUnread: unreadDmCount > 0,
            onTap: onSelectDms,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: isDmsSelected
                      ? AppColors.primaryPurple
                      : AppColors.surfaceLight,
                  child: Icon(
                    Icons.chat_bubble_rounded,
                    color: isDmsSelected
                        ? Colors.white
                        : AppColors.textSecondary,
                    size: 21,
                  ),
                ),
                if (unreadDmCount > 0 && !isDmsSelected)
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.errorRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child:
                Divider(color: AppColors.cardBorder, height: 1, thickness: 1.2),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: stores.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 6),
              itemBuilder: (_, index) {
                if (index == stores.length) {
                  return RailItemButton(
                    isSelected: false,
                    hasUnread: false,
                    onTap: onDiscoverStoresTap,
                    child: Container(
                      color: AppColors.surfaceLight,
                      child: const Icon(
                        Icons.add_rounded,
                        color: AppColors.accentCyan,
                        size: 24,
                      ),
                    ),
                  );
                }

                final store = stores[index];
                final isSelected = selectedStoreId == store.id;

                return RailItemButton(
                  isSelected: isSelected,
                  hasUnread: store.unreadCount > 0,
                  onTap: () => onSelectStore(store),
                  child: _buildStoreIcon(store, isSelected),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}