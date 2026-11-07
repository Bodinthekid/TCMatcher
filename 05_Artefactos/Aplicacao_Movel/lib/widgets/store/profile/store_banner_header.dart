import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../shared/header_icon_button.dart';
import '../common/store_avatar_badge.dart';

class StoreBannerHeader extends StatelessWidget {
  const StoreBannerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=900&q=80',
            height: 155,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(height: 155, color: AppColors.surfaceLight),
          ),
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderIconButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => Navigator.maybePop(context),
                ),
                Row(
                  children: [
                    HeaderIconButton(
                      icon: Icons.favorite_border_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    HeaderIconButton(
                      icon: Icons.share_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            left: 20,
            bottom: 0,
            child: StoreAvatarBadge(size: 62),
          ),
        ],
      ),
    );
  }
}